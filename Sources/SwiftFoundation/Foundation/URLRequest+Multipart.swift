//
//  URLRequest+Multipart.swift
//  SwiftFoundation
//
//  Created by Max Kuznetsov on 25.10.2020.
//

import Foundation

#if os(iOS)
import MobileCoreServices

public extension URLRequest {
    
    public init(url: URL,
         method: HTTPMethod = .post,
         headers: [String: String] = [:],
         multipartFormData constructingBlock: @escaping (_ formData: MultipartFormData) -> Void)
    {
        self.init(url: url)
        self.httpMethod = method.rawValue
        self.httpBody = Data()
        let formData = MultipartFormData(request: self)
        constructingBlock(formData)
        formData.finalize()
        self = formData.request
        for (k,v) in headers {
            self.addValue(v, forHTTPHeaderField: k)
        }
    }
    
    open class MultipartFormData {
        public var request: URLRequest
        private lazy var boundary: String = {
            return String(format: "%08X%08X", arc4random(), arc4random())
        }()
        
        public init(request: URLRequest) {
            self.request = request
        }
        
        public func append(value: String, name: String) {
            request.httpBody?.append("--\(boundary)\r\n".data())
            request.httpBody?.append("Content-Disposition: form-data; name=\"\(name)\"\r\n\r\n".data())
            request.httpBody?.append("\(value)\r\n".data())
        }
        
        public func append(filePath: String, name: String) throws {
            let url = URL(fileURLWithPath: filePath)
            try append(fileUrl: url, name: name)
        }
        
        public func append(fileUrl: URL, name: String) throws {
            let fileName = fileUrl.lastPathComponent
            let mimeType = contentType(for: fileUrl.pathExtension)
            try append(fileUrl: fileUrl, name: name, fileName: fileName, mimeType: mimeType)
        }
        
        public func append(fileUrl: URL, name: String, fileName: String, mimeType: String) throws {
            let data = try Data(contentsOf: fileUrl)
            append(file: data, name: name, fileName: fileName, mimeType: mimeType)
        }
        
        public func append(file: Data, name: String, fileName: String, mimeType: String) {
            request.httpBody?.append("--\(boundary)\r\n".data())
            request.httpBody?.append("Content-Disposition: form-data; name=\"\(name)\";".data())
            request.httpBody?.append("filename=\"\(fileName)\"\r\n".data())
            request.httpBody?.append("Content-Type: \(mimeType)\r\n\r\n".data())
            request.httpBody?.append(file)
            request.httpBody?.append("\r\n".data())
        }
        
        fileprivate func finalize() {
            request.httpBody?.append("--\(boundary)--\r\n".data())
            request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        }
    }
}

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
