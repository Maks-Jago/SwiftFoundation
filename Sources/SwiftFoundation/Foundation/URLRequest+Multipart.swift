//===--- URLRequest+Multipart.swift ---------------------------------------===//
//
// This source file is part of the SwiftFoundation open source project
//
// Copyright (c) 2024 You are launched
// Licensed under MIT license
//
// See https://opensource.org/licenses/MIT for license information
//
//===----------------------------------------------------------------------===//

import Foundation

#if os(iOS)
import MobileCoreServices

/// An enumeration representing HTTP methods.
public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
    case head = "HEAD"
    case patch = "PATCH"
}

public extension URLRequest {
    
    /// Initializes a `URLRequest` for multipart form data upload.
    /// - Parameters:
    ///   - url: The URL for the request.
    ///   - method: The HTTP method to use. Default is `.post`.
    ///   - headers: Additional headers to include in the request. Default is an empty dictionary.
    ///   - constructingBlock: A closure that constructs the multipart form data.
    init(url: URL,
         method: HTTPMethod = .post,
         headers: [String: String] = [:],
         multipartFormData constructingBlock: @escaping (_ formData: MultipartFormData) -> Void) {
        self.init(url: url)
        self.httpMethod = method.rawValue
        self.httpBody = Data()
        let formData = MultipartFormData(request: self)
        constructingBlock(formData)
        formData.finalize()
        self = formData.request
        for (k, v) in headers {
            self.addValue(v, forHTTPHeaderField: k)
        }
    }
    
    /// A class that manages the construction of multipart form data for a `URLRequest`.
    class MultipartFormData {
        /// The `URLRequest` associated with the multipart form data.
        public var request: URLRequest
        private lazy var boundary: String = {
            return String(format: "%08X%08X", arc4random(), arc4random())
        }()
        
        /// Initializes the `MultipartFormData` with a `URLRequest`.
        /// - Parameter request: The `URLRequest` to use.
        public init(request: URLRequest) {
            self.request = request
        }
        
        /// Appends a value to the multipart form data.
        /// - Parameters:
        ///   - value: The string value to append.
        ///   - name: The name associated with the value.
        public func append(value: String, name: String) {
            request.httpBody?.append("--\(boundary)\r\n".toData()!)
            request.httpBody?.append("Content-Disposition: form-data; name=\"\(name)\"\r\n\r\n".toData()!)
            request.httpBody?.append("\(value)\r\n".toData()!)
        }
        
        /// Appends a file to the multipart form data using its file path.
        /// - Parameters:
        ///   - filePath: The file path of the file to append.
        ///   - name: The name associated with the file.
        /// - Throws: An error if the file cannot be accessed.
        public func append(filePath: String, name: String) throws {
            let url = URL(fileURLWithPath: filePath)
            try append(fileUrl: url, name: name)
        }
        
        /// Appends a file to the multipart form data using its URL.
        /// - Parameters:
        ///   - fileUrl: The URL of the file to append.
        ///   - name: The name associated with the file.
        /// - Throws: An error if the file cannot be accessed.
        public func append(fileUrl: URL, name: String) throws {
            let fileName = fileUrl.lastPathComponent
            let mimeType = contentType(for: fileUrl.pathExtension)
            try append(fileUrl: fileUrl, name: name, fileName: fileName, mimeType: mimeType)
        }
        
        /// Appends a file to the multipart form data with a specified file name and MIME type.
        /// - Parameters:
        ///   - fileUrl: The URL of the file to append.
        ///   - name: The name associated with the file.
        ///   - fileName: The name of the file.
        ///   - mimeType: The MIME type of the file.
        /// - Throws: An error if the file cannot be accessed.
        public func append(fileUrl: URL, name: String, fileName: String, mimeType: String) throws {
            let data = try Data(contentsOf: fileUrl)
            append(file: data, name: name, fileName: fileName, mimeType: mimeType)
        }
        
        /// Appends a file to the multipart form data using its data representation.
        /// - Parameters:
        ///   - file: The data of the file to append.
        ///   - name: The name associated with the file.
        ///   - fileName: The name of the file.
        ///   - mimeType: The MIME type of the file.
        public func append(file: Data, name: String, fileName: String, mimeType: String) {
            request.httpBody?.append("--\(boundary)\r\n".toData()!)
            request.httpBody?.append("Content-Disposition: form-data; name=\"\(name)\";".toData()!)
            request.httpBody?.append("filename=\"\(fileName)\"\r\n".toData()!)
            request.httpBody?.append("Content-Type: \(mimeType)\r\n\r\n".toData()!)
            request.httpBody?.append(file)
            request.httpBody?.append("\r\n".toData()!)
        }
        
        /// Finalizes the multipart form data, adding the closing boundary.
        fileprivate func finalize() {
            request.httpBody?.append("--\(boundary)--\r\n".toData()!)
            request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        }
    }
}

/// Returns the MIME type for a given file extension.
/// - Parameter pathExtension: The file extension.
/// - Returns: The corresponding MIME type as a string, or "application/octet-stream" if the type cannot be determined.
public func contentType(for pathExtension: String) -> String {
    guard let uti = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, pathExtension as CFString, nil)?.takeRetainedValue() else {
        return "application/octet-stream"
    }
    let contentTypeCString = UTTypeCopyPreferredTagWithClass(uti, kUTTagClassMIMEType)?.takeRetainedValue()
    guard let contentType = contentTypeCString as String? else {
        return "application/octet-stream"
    }
    return contentType
}
#endif
