//
//  CGSize.swift
//  
//
//  Created by Max Kuznetsov on 19.08.2021.
//

import Foundation
#if os(iOS)
import UIKit
typealias Screen = UIScreen

#else
import AppKit
typealias Screen = NSScreen
#endif


public extension CGSize {
    static func scaledSize(_ size: CGSize) -> CGSize {
        #if os(iOS)
        let scale = Screen.main.scale
        #else
        let scale = Screen.main?.backingScaleFactor
        #endif
        
        return CGSize(width: size.width * (scale ?? 1), height: size.height * (scale ?? 1))
    }

    var scaledSize: CGSize { Self.scaledSize(self) }
}
