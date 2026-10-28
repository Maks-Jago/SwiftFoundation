import Foundation
import Testing
import XCTest
@testable import SwiftFoundation
import struct CoreGraphics.CGSize

final class SwiftFoundationTests: XCTestCase {
}

@Suite("CGSize Scaled Size Tests")
struct CGSizeScaledSizeTests {
    @Test("scaledSize computed property matches static method")
    func scaledSizeMatchesStaticMethod() {
        let size = CGSize(width: 100, height: 50)
        let propertyScaled = size.scaledSize
        let staticScaled = CGSize.scaledSize(size)

        #expect(propertyScaled == staticScaled)
    }

    @Test("scaledSize with zero size produces zero")
    func scaledSizeZero() {
        let size = CGSize.zero
        let scaled = size.scaledSize

        #expect(scaled.width == 0)
        #expect(scaled.height == 0)
        #expect(scaled == CGSize.zero)
    }

#if os(iOS)
    @Test("scaledSize on iOS scales according to screen scale or falls back to 1.0")
    func scaledSizeIOS() {
        let size = CGSize(width: 100, height: 50)
        let scaled = size.scaledSize

        #expect(scaled.width > 0)
        #expect(scaled.height > 0)
        #expect(scaled.width == scaled.height * 2)
    }
#else
    @Test("scaledSize on non-iOS platforms returns original size")
    func scaledSizeNonIOS() {
        let size = CGSize(width: 100, height: 50)
        let scaled = size.scaledSize

        #expect(scaled.width == 100)
        #expect(scaled.height == 50)
        #expect(scaled == CGSize(width: 100, height: 50))
    }
#endif
}
