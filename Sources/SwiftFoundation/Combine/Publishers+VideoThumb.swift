//
//  Publishers+VideoThumb.swift
//  SwiftFoundation
//
//  Created by Max Kuznetsov on 25.10.2020.
//

import Foundation
import Combine
import AVFoundation

#if os(iOS)
import UIKit
typealias Image = UIImage

#else
import AppKit
typealias Image = NSImage
#endif

extension Publishers {
    static func imageFrom(videoURL: URL, at time: CMTime = CMTimeMake(value: 2, timescale: 1)) -> AnyPublisher<Image, Error> {
        Deferred {
            Future<Image, Error> { promise in
                DispatchQueue.global(qos: .userInitiated).async {
                    let asset = AVAsset(url: videoURL)
                    
                    let avAssetImageGenerator = AVAssetImageGenerator(asset: asset)
                    avAssetImageGenerator.appliesPreferredTrackTransform = true
                    
                    promise(Result {
                        #if os(iOS)
                        return UIImage(cgImage: try avAssetImageGenerator.copyCGImage(at: time, actualTime: nil))
                        #else
                        return NSImage(cgImage: try avAssetImageGenerator.copyCGImage(at: time, actualTime: nil), size: .zero)
                        #endif
                    })
                }
            }
        }
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
}
