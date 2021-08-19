//
//  CGSize.swift
//  
//
//  Created by Max Kuznetsov on 19.08.2021.
//

import Foundation
import UIKit

public extension CGSize {
    static func scaledSize(_ size: CGSize) -> CGSize {
        CGSize(width: size.width * UIScreen.main.scale, height: size.height * UIScreen.main.scale)
    }

    var scaledSize: CGSize { Self.scaledSize(self) }
}
