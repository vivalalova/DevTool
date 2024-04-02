//
//  SwiftUIView.swift
//
//  Created by Lova on 2024/4/1.
//

import Combine
import HandyJSON
import SwiftUI

public
extension Fetch {
    func call(request: URLRequest, showHUD: Bool = false, showErrorMessage: Bool) -> AnyPublisher<Data, any Error> {
        if showHUD {
            self.show(progress: nil)
        }

        return URLSession.shared.dataTaskPublisher(for: request)
            .receive(on: DispatchQueue.main)
            .tryMap { response -> Data in
                try self.afterRequest(data: response.data, showHUD: showHUD, response: response.response, request: request, showErrorMessage: showErrorMessage)
            }
            .eraseToAnyPublisher()
    }

    func fetch(method: HttpMethod = .get, path: String, params: [String: Any] = [:], showHUD: Bool = false, showErrorMessage: Bool = false) -> AnyPublisher<Data, any Error> {
        let request = self.request(method: method, path: path, params: params, showHUD: showHUD, showErrorMessage: showErrorMessage)
        return self.call(request: request, showHUD: showHUD, showErrorMessage: showErrorMessage)
    }
}

public
extension Fetch {
    func fetch(method: HttpMethod = .get, path: String, params: [String: Any] = [:], showHUD: Bool = false, showErrorMessage: Bool = false) -> Response<String?> {
        self.fetch(method: method, path: path, params: params, showHUD: showHUD, showErrorMessage: showErrorMessage)
            .map { String(data: $0, encoding: .utf8) }
            .receive(on: DispatchQueue.main)
            .mapError {
                logger.error("\($0)")
                return $0
            }
            .eraseToAnyPublisher()
    }

    func fetch(method: HttpMethod = .get, path: String, params: [String: Any] = [:], showHUD: Bool = false, showErrorMessage: Bool = false) -> Response<[String: Any]?> {
        self.fetch(method: method, path: path, params: params, showHUD: showHUD, showErrorMessage: showErrorMessage)
            .map { try? JSONSerialization.jsonObject(with: $0, options: .allowFragments) as? [String: Any] }
            .receive(on: DispatchQueue.main)
            .mapError {
                logger.error("\($0)")
                return $0
            }
            .eraseToAnyPublisher()
    }

    func fetch<T: HandyJSON>(method: HttpMethod = .get, path: String, params: [String: Any] = [:], showHUD: Bool = false, showErrorMessage: Bool = false) -> Response<[T]> {
        self.fetch(method: method, path: path, params: params, showHUD: showHUD, showErrorMessage: showErrorMessage)
            .map { data in
                let string = String(data: data, encoding: .utf8)
                return JSONDeserializer.deserializeModelArrayFrom(json: string)?.compactMap { $0 } ?? []
            }
            .receive(on: DispatchQueue.main)
            .mapError {
                logger.error("\($0)")
                return $0
            }
            .eraseToAnyPublisher()
    }

    func fetch<T: HandyJSON>(method: HttpMethod = .get, path: String, params: [String: Any] = [:], showHUD: Bool = false, showErrorMessage: Bool = false) -> Response<T?> {
        self.fetch(method: method, path: path, params: params, showHUD: showHUD, showErrorMessage: showErrorMessage)
            .map { data in
                let string = String(data: data, encoding: .utf8)
                return JSONDeserializer.deserializeFrom(json: string)
            }
            .receive(on: DispatchQueue.main)
            .mapError {
                logger.error("\($0)")
                return $0
            }
            .eraseToAnyPublisher()
    }

    func fetch(method: HttpMethod = .get, path: String, params: [String: Any] = [:], showHUD: Bool = false, showErrorMessage: Bool = false) -> Response<Void> {
        let result: AnyPublisher<Data, any Error> = self.fetch(method: method, path: path, params: params, showHUD: showHUD, showErrorMessage: showErrorMessage)

        return result
            .map { _ in }
            .receive(on: DispatchQueue.main)
            .mapError {
                logger.error("\($0)")
                return $0
            }
            .eraseToAnyPublisher()
    }
}
