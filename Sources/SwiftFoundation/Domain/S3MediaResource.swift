//
//  S3MediaResource.swift
//  
//
//  Created by Max Kuznetsov on 19.08.2021.
//

import Foundation
import SwiftUI
import struct CoreGraphics.CGSize

public struct S3MediaResource: Codable {
    public struct Id: Hashable, Codable {
        public var value: Int

        public init(_ value: Int) {
            self.value = value
        }
    }

    public var id: Id
    public var mediaUrlPath: String

    public var configs: Configs

    private static var defaultConfigs: Configs? = nil

    public static func setDefault(configs: Configs) {
        defaultConfigs = configs
    }

    public init(id: S3MediaResource.Id, mediaUrlPath: String, configs: Configs? = nil) {
        self.id = id
        self.mediaUrlPath = mediaUrlPath

        guard let mediaConfigs = configs ?? Self.defaultConfigs else {
            fatalError("S3MediaResource couldn't be created without `configs`. You must provide `configs` as init parameter or set default configs via `S3MediaResource.setDefault(configs:)` method")
        }

        self.configs = mediaConfigs
    }

    /// Get an original image URL, without size compression
    /// - Returns: Original URL (CDN, S3)
    public func originalImageURL() throws -> URL {
        try _imageURL(.fit, in: nil)
    }

    /// Get an scaled image URL
    /// - Parameter contentMode: A flag indicating whether this image should fit or fill the parent context.
    /// - Parameter size: Target size for image resizing. Size will be scaled with a device scale factor. Example CGSize(width: 120, height: 120).scaledSize
    /// - Returns: Scaled image URL (CDN, S3).
    public func scaledImageURL(_ contentMode: ContentMode = .fit, in size: CGSize) throws -> URL {
        try _imageURL(contentMode, in: size.scaledSize)
    }

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
    enum MediaResourceError: Error {
        case invalidMediaURL
        case jsonIsNotConvertableToBase64
        case invalidCDNURL
    }
}

// MARK: - Configs
public extension S3MediaResource {
    struct Configs: Codable {
        public var bucketName: String
        public var cdnBaseURLPath: String

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

extension S3MediaResource: Identifiable {}

// MARK: - Faking
extension S3MediaResource: Faking {
    public init() {
        id = .init(.random(in: 0...Int.max))
        mediaUrlPath = "https://www.urlaunched.com/ms-icon-310x310.png"
        configs = Self.defaultConfigs!
    }
}
