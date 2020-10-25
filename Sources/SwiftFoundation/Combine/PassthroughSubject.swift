//
//  PassthroughSubject.swift
//  SwiftFoundation
//
//  Created by Max Kuznetsov on 25.10.2020.
//

import Combine

public extension PassthroughSubject where Output == Void {
    
    func sendAction() -> () -> Void {
        return {
            self.send(())
        }
    }
}
