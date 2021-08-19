//
//  S3MediaResource.swift
//  
//
//  Created by Max Kuznetsov on 19.08.2021.
//

import Foundation
import struct CoreGraphics.CGSize

public struct S3MediaResource {
    public struct Id: Hashable {
        var value: Int
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

    public func imageURL(fitIn size: CGSize? = nil) throws -> URL {
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
                "width": \(size.width),
                "height": \(size.height),
                "fit": "cover"
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
    struct Configs {
        public var bucketName: String
        public var cdnBaseURLPath: String

        public init(bucketName: String, cdnBaseURLPath: String) {
            self.bucketName = bucketName
            self.cdnBaseURLPath = cdnBaseURLPath
        }
    }
}
