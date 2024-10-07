//===--- S3MediaResource.swift --------------------------------------------===//
//
// This source file is part of the SwiftFoundation open source project
//
// Copyright (c) 2024 You Are Launched
// Licensed under Apache License v2.0
//
// See https://opensource.org/licenses/Apache-2.0 for license information
//
//===----------------------------------------------------------------------===//

import Foundation
import SwiftUI
import struct CoreGraphics.CGSize

/// A structure representing a media resource that holds a media URL and configuration settings.
public struct S3MediaResource: Codable {
    
    /// A nested struct representing the unique identifier for an `S3MediaResource`.
    public struct Id: Hashable, Codable {
        /// The value of the ID.
        public var value: Int
        
        /// Initializes a new `Id` with a given integer value.
        /// - Parameter value: The unique identifier value.
        public init(_ value: Int) {
            self.value = value
        }
    }
    
    /// The unique identifier for the media resource.
    public var id: Id
    /// The path to the media URL.
    public var mediaUrlPath: String
    /// Configuration settings for the media resource.
    public var configs: Configs
    
    /// Holds the default configuration settings (optional).
    private static var defaultConfigs: Configs? = nil
    
    /// Sets the default configuration settings.
    /// - Parameter configs: The `Configs` to set as default.
    public static func setDefault(configs: Configs) {
        defaultConfigs = configs
    }
    
    /// Initializes a new `S3MediaResource`.
    /// - Parameters:
    ///   - id: The unique identifier for the resource.
    ///   - mediaUrlPath: The path to the media URL.
    ///   - configs: Optional configuration. If not provided, will use the default configs.
    /// - Note: This initializer will cause a fatal error if no `configs` are provided and no default configuration is set.
    public init(id: S3MediaResource.Id, mediaUrlPath: String, configs: Configs? = nil) {
        self.id = id
        self.mediaUrlPath = mediaUrlPath
        
        guard let mediaConfigs = configs ?? Self.defaultConfigs else {
            fatalError("S3MediaResource couldn't be created without `configs`. You must provide `configs` as init parameter or set default configs via `S3MediaResource.setDefault(configs:)` method")
        }
        
        self.configs = mediaConfigs
    }
    
    /// Retrieves the original image URL without size compression.
    /// - Returns: The original URL (CDN, S3).
    /// - Throws: `MediaResourceError.invalidMediaURL` if the media URL is not valid.
    public func originalImageURL() throws -> URL {
        try _imageURL(.fit, in: nil)
    }
    
    /// Retrieves a scaled image URL.
    /// - Parameters:
    ///   - contentMode: A flag indicating whether this image should fit or fill the parent context. Defaults to `.fit`.
    ///   - size: The target size for image resizing. The size will be scaled with a device scale factor (e.g., `CGSize(width: 120, height: 120).scaledSize`).
    /// - Returns: The scaled image URL (CDN, S3).
    /// - Throws: `MediaResourceError.invalidMediaURL` or `MediaResourceError.invalidCDNURL` if the URL is not valid.
    public func scaledImageURL(_ contentMode: ContentMode = .fit, in size: CGSize) throws -> URL {
        try _imageURL(contentMode, in: size.scaledSize)
    }
    
    /// Generates an image URL based on the content mode and size.
    /// - Parameters:
    ///   - contentMode: A flag indicating whether the image should fit or fill the parent context.
    ///   - size: The target size for resizing. Can be `nil` for the original size.
    /// - Returns: A URL pointing to the image.
    /// - Throws: `MediaResourceError.invalidMediaURL` or `MediaResourceError.invalidCDNURL` if URL creation fails.
    private func _imageURL(_ contentMode: ContentMode, in size: CGSize?) throws -> URL {
        guard let mediaURL = URL(string: mediaUrlPath) else {
            throw MediaResourceError.invalidMediaURL
        }
        
        let imageKey = mediaURL.pathComponents.joined(separator: "/").trimmingCharacters(in: CharacterSet(charactersIn: "/"))
        
        var jsonString = """
        {
        "bucket": "\(configs.bucketName)",
        "key": "\(imageKey)"
        """
        
        if let size = size {
            jsonString.append(",")
            jsonString.append(
                """
                "edits": {
                "resize": {
                "width": \(Int(size.width)),
                "height": \(Int(size.height)),
                "fit": "\(contentMode == .fit ? "contain" : "cover")",
                "background": { "r": 255, "g": 255, "b": 255, "alpha": 0 }
                }
                }
                """
            )
        }
        
        jsonString.append("}")
        jsonString = jsonString.replacingOccurrences(of: "\n", with: "")
        
        let base64String = jsonString.toBase64()
        
        guard let cdnURL = URL(string: configs.cdnBaseURLPath + base64String) else {
            throw MediaResourceError.invalidCDNURL
        }
        
        return cdnURL
    }
}

// MARK: - Error

public extension S3MediaResource {
    /// Enum representing possible errors for media resource.
    enum MediaResourceError: Error {
        case invalidMediaURL
        case jsonIsNotConvertableToBase64
        case invalidCDNURL
    }
}

// MARK: - Configs

public extension S3MediaResource {
    /// A structure representing configuration settings for the media resource.
    struct Configs: Codable {
        /// The name of the bucket.
        public var bucketName: String
        /// The base URL path for the CDN.
        public var cdnBaseURLPath: String
        
        /// Initializes new configuration settings.
        /// - Parameters:
        ///   - bucketName: The name of the bucket.
        ///   - cdnBaseURLPath: The base URL path for the CDN.
        public init(bucketName: String, cdnBaseURLPath: String) {
            self.bucketName = bucketName
            self.cdnBaseURLPath = cdnBaseURLPath
        }
    }
}

// MARK: - Equatable

extension S3MediaResource: Equatable {
    public static func == (lhs: S3MediaResource, rhs: S3MediaResource) -> Bool {
        lhs.mediaUrlPath == rhs.mediaUrlPath && lhs.id == rhs.id
    }
}

// MARK: - Hashable

extension S3MediaResource: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(mediaUrlPath)
    }
}

// MARK: - Identifiable

extension S3MediaResource: Identifiable {}

// MARK: - Faking

extension S3MediaResource: Faking {
    /// Initializes a new `S3MediaResource` with fake data for testing.
    public init() {
        id = .init(.random(in: 0...Int.max))
        mediaUrlPath = "https://www.urlaunched.com/ms-icon-310x310.png"
        configs = Self.defaultConfigs!
    }
}
