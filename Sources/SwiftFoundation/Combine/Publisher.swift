//
//  Publisher.swift
//  SwiftFoundation
//
//  Created by Max Kuznetsov on 25.10.2020.
//

import Combine

public extension Publisher {
    func sinkError(_ receiveError: @escaping ((Self.Failure) -> Void), receiveValue: @escaping ((Self.Output) -> Void)) -> AnyCancellable {
        self.sink(receiveCompletion: { compl in
            if case let .failure(error) = compl {
                receiveError(error)
            }
        }, receiveValue: receiveValue)
    }
}
