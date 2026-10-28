//===--- UIScreen.swift ---------------------------------------------------===//
//
// This source file is part of the SwiftFoundation open source project
//
// Copyright (c) 2026 You are launched
// Licensed under MIT license
//
// See https://opensource.org/licenses/MIT for license information
//
//===----------------------------------------------------------------------===//

#if os(iOS)
import UIKit

public extension UIScreen {
    static var currentScale: CGFloat? {
        let scenes = UIApplication.shared.connectedScenes.compactMap { $0 as? UIWindowScene }

        var activeMaxScale: CGFloat?
        var inactiveMaxScale: CGFloat?
        var anyMaxScale: CGFloat?

        for scene in scenes {
            let scale = scene.screen.scale
            anyMaxScale = max(anyMaxScale ?? 0, scale)

            switch scene.activationState {
            case .foregroundActive:
                activeMaxScale = max(activeMaxScale ?? 0, scale)
            case .foregroundInactive:
                inactiveMaxScale = max(inactiveMaxScale ?? 0, scale)
            default:
                break
            }
        }

        if let activeMaxScale {
            return activeMaxScale
        }

        if let inactiveMaxScale {
            return inactiveMaxScale
        }

        if let anyMaxScale {
            return anyMaxScale
        }

        let traitScale = UITraitCollection.current.displayScale
        return traitScale > 0 ? traitScale : nil
    }
}
#endif
