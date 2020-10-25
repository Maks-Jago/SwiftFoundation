//
//  Math.swift
//  SwiftFoundation
//
//  Created by Max Kuznetsov on 25.10.2020.
//

import Foundation
import CoreGraphics

func ceilCGF(_ value: CGFloat) -> CGFloat {
    CGFloat(ceilf(Float(value)))
}

func roundCGF(_ value: CGFloat) -> CGFloat {
    CGFloat(roundf(Float(value)))
}

func floorCGF(_ value: CGFloat) -> CGFloat {
    CGFloat(floorf(Float(value)))
}
