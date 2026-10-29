import Foundation
import Testing
import XCTest
@testable import SwiftFoundation

final class SwiftFoundationTests: XCTestCase {
}

@Suite("Scaled size")
struct ScaledSizeTests {
    @Test("scaledSize multiplies the size by the provided scale")
    func scaledSizeWithScale() {
        #expect(CGSize(width: 100, height: 50).scaledSize(scale: 3) == CGSize(width: 300, height: 150))
    }

    @Test("scaledImageURL requests the size multiplied by the provided scale")
    func scaledImageURLWithScale() throws {
        let configs = S3MediaResource.Configs(bucketName: "bucket", cdnBaseURLPath: "https://cdn.example.com/")
        let resource = S3MediaResource(id: .init(1), mediaUrlPath: "/images/photo.jpg", configs: configs)

        let url = try resource.scaledImageURL(in: CGSize(width: 120, height: 80), scale: 3)

        let encoded = url.absoluteString.replacingOccurrences(of: configs.cdnBaseURLPath, with: "")
        let json = try #require(encoded.fromBase64())
        let object = try #require(try JSONSerialization.jsonObject(with: Data(json.utf8)) as? [String: Any])
        let edits = try #require(object["edits"] as? [String: Any])
        let resize = try #require(edits["resize"] as? [String: Any])

        #expect(resize["width"] as? Int == 360)
        #expect(resize["height"] as? Int == 240)
    }

    @available(*, deprecated)
    @Test("deprecated scaledSize keeps using the scale of the main screen")
    func deprecatedScaledSize() {
        let size = CGSize(width: 100, height: 50)

        #expect(size.scaledSize == size.scaledSize(scale: nil))
    }
}
