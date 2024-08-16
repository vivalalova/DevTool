//
//  AnyPublisher+.swift
//
//  Created by Lova on 2024/3/29.
//

import Combine
import UIKit

public
extension Publisher where Failure == Never {
    func task(receiveValue: @escaping ((Self.Output) async -> Void)) -> AnyCancellable {
        sink { value in
            Task { @MainActor in
                await receiveValue(value)
            }
        }
    }
}

public
extension AnyPublisher where Output == Any?, Failure == Never {
    func filterNil() -> AnyPublisher<Output, Never> {
        compactMap { $0 }
            .eraseToAnyPublisher()
    }
}

public
extension AnyPublisher {
    func void() -> AnyPublisher<Void, Never> {
        return map { _ in }
            .catch { _ in Empty<Void, Never>() }
            .eraseToAnyPublisher()
    }

    func nothing() -> AnyCancellable {
        sink(receiveCompletion: { _ in }, receiveValue: { _ in })
    }
}

public
extension AnyPublisher {
    func task(success: ((Output) async -> Void)? = nil, fail: ((Failure) async -> Void)? = nil) -> AnyCancellable {
        self.sink { result in
            switch result {
            case .finished:
                break
            case let .failure(e):
                Task {
                    await fail?(e)
                }
            }
        } receiveValue: { value in
            Task {
                await success?(value)
            }
        }
    }

    func sink(success: ((Output) -> Void)? = nil, fail: ((Failure) -> Void)? = nil) -> AnyCancellable {
        self.sink { result in
            switch result {
            case .finished:
                break
            case let .failure(e):
                fail?(e)
            }
        } receiveValue: { value in
            success?(value)
        }
    }
}
