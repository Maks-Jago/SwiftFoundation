//
//  ObservableObjectPublisher.swift
//  SwiftFoundation
//
//  Created by Max Kuznetsov on 25.10.2020.
//

import Combine

public extension ObservableObjectPublisher {
    
    func sendAction() -> () -> Void {
        return {
            self.send()
        }
    }
}
