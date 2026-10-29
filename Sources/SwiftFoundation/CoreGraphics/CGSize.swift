//===--- CGSize.swift -----------------------------------------------------===//
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
import UIKit
typealias Screen = UIScreen
#else
import AppKit
typealias Screen = NSScreen
#endif

public extension CGSize {
    /// Returns the size multiplied by a display scale.
    /// - Parameter scale: The display scale, e.g. `displayScale` from the SwiftUI environment
    ///   or `traitCollection.displayScale` of a UIKit view. It has no default value on purpose.
    ///   If `nil`, the scale of the main screen of the device is used.
    func scaledSize(scale: CGFloat?) -> CGSize {
        let scale = scale ?? mainScreenScale
        return CGSize(width: width * scale, height: height * scale)
    }

    @available(*, deprecated, message: "Use `scaledSize(scale:)` and pass the scale explicitly, or `nil` to use the scale of the main screen.")
    static func scaledSize(_ size: CGSize) -> CGSize {
        size.scaledSize(scale: nil)
    }

    @available(*, deprecated, message: "Use `scaledSize(scale:)` and pass the scale explicitly, or `nil` to use the scale of the main screen.")
    var scaledSize: CGSize { scaledSize(scale: nil) }

    private var mainScreenScale: CGFloat {
#if os(iOS)
        Screen.main.scale
#else
        Screen.main?.backingScaleFactor ?? 1.0
#endif
    }
}
