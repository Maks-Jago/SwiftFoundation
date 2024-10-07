//===--- CGSize.swift -----------------------------------------------------===//
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

#if os(iOS)
import UIKit
typealias Screen = UIScreen
#else
import AppKit
typealias Screen = NSScreen
#endif

public extension CGSize {
    /// Returns a new `CGSize` that is scaled based on the screen's scale factor.
    /// - Parameter size: The original size to be scaled.
    /// - Returns: A new `CGSize` that is adjusted for the screen's scale factor.
    static func scaledSize(_ size: CGSize) -> CGSize {
#if os(iOS)
        let scale = Screen.main.scale
#else
        let scale = Screen.main?.backingScaleFactor ?? 1.0
#endif
        
        return CGSize(width: size.width * scale, height: size.height * scale)
    }
    
    /// A computed property that returns the size scaled according to the screen's scale factor.
    var scaledSize: CGSize { Self.scaledSize(self) }
}
