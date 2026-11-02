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

@Suite("S3MediaResource Tests")
struct S3MediaResourceTests {
    private let baseURL = "https://cdn.example.com/"

    private var resource: S3MediaResource {
        S3MediaResource(
            id: .init(1),
            mediaUrlPath: "https://example.com/images/sample.jpg",
            configs: .init(bucketName: "test-bucket", cdnBaseURLPath: baseURL)
        )
    }

    private func resizeDimensions(from url: URL) throws -> (width: Int, height: Int) {
        struct Payload: Decodable {
            struct Edits: Decodable {
                struct Resize: Decodable {
                    let width: Int
                    let height: Int
                }
                let resize: Resize
            }
            let edits: Edits
        }

        let base64 = String(url.absoluteString.dropFirst(baseURL.count))
        let data = try #require(Data(base64Encoded: base64))
        let payload = try JSONDecoder().decode(Payload.self, from: data)
        return (payload.edits.resize.width, payload.edits.resize.height)
    }

    @Test("Rounds fractional dimensions to nearest hardcoded integers")
    func roundsDimensionsToNearestIntegers() throws {
        let scale = CGSize(width: 1, height: 1).scaledSize.width

        // 375.3333 rounds down to 375, 250.6666 rounds up to 251
        let url1 = try resource.scaledImageURL(in: CGSize(width: 375.3333 / scale, height: 250.6666 / scale))
        let dims1 = try resizeDimensions(from: url1)
        #expect(dims1.width == 375)
        #expect(dims1.height == 251)

        // 100.5 rounds up to 101, 200.4 rounds down to 200
        let url2 = try resource.scaledImageURL(in: CGSize(width: 100.5 / scale, height: 200.4 / scale))
        let dims2 = try resizeDimensions(from: url2)
        #expect(dims2.width == 101)
        #expect(dims2.height == 200)
    }
}
