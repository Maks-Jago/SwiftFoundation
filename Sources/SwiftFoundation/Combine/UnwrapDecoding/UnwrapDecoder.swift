//
//  UnwrapDecoder.swift
//  
//
//  Created by Max Kuznetsov on 30.12.2020.
//

import Foundation
import Combine

public protocol UnwrapDecoder: TopLevelDecoder {
    var userInfo: [CodingUserInfoKey : Any] { get set }
}

extension JSONDecoder: UnwrapDecoder {}
