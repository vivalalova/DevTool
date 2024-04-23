//
//  Body.swift
//  LOAPI
//
//  Created by Lova on 2020/3/29.
//

import Combine
import DevToolCore
import Foundation
import HandyJSON
import OSLog

let logger = Logger()

public
extension Fetch {
    typealias Response<T> = AnyPublisher<T, Error>
    typealias PreResponse = Publishers.TryMap<Publishers.ReceiveOn<URLSession.DataTaskPublisher, DispatchQueue>, Data>

    func request(method: HttpMethod = .get, path: String, params: [String: Any] = [:], showHUD: Bool = false, showErrorMessage: Bool = false) -> URLRequest {
        var parameters = params

        parameters = self.willSend(params: &parameters, method: method, path: path)

        guard let url = URL(string: domain + path) else {
            fatalError("not a url")
        }

        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue

        switch method {
        case .get:
            request.url = url.addParameter(parameters)
        case .post, .put, .delete:
            request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")

            guard let data = try? JSONSerialization.data(withJSONObject: params) else {
                fatalError("data failed")
            }

            request.httpBody = data
        }

        return self.willSend(request: &request, method: method, path: path, params: parameters)
    }
}

extension Fetch {
    func afterRequest(data: Data, showHUD: Bool, response: URLResponse, request: URLRequest, showErrorMessage: Bool) throws -> Data {
        if showHUD {
            self.hide(progress: nil)
        }

        guard let httpResponse = response as? HTTPURLResponse else {
            let error = URLError(.badServerResponse)

            self.on(error, of: request, isShow: showErrorMessage)

            throw error
        }

        guard httpResponse.statusCode == 200 else {
            let error = URLError(
                .init(rawValue: httpResponse.statusCode),
                userInfo: [
                    "method": request.httpMethod ?? "",
                    "url": request.debugDescription,
                    "body": String(data: request.httpBody ?? Data(), encoding: .utf8) ?? "",
                    "response": String(data: data, encoding: .utf8) ?? ""
                ]
            )

            self.on(error, of: request, isShow: showErrorMessage)

            throw error
        }

        return data
    }
}

public
extension Publisher<Data, any Error> {
    func fromObject<T: HandyJSON>(mapPath: String) -> AnyPublisher<T?, any Error> {
        self.map { try? JSONSerialization.jsonObject(with: $0) as? [String: Any] }
            .map { $0?[mapPath] as? [String: Any] }
            .map { JSONDeserializer.deserializeFrom(dict: $0) }
            .mapError {
                logger.error("\($0)")
                return $0
            }
            .eraseToAnyPublisher()
    }

    func fromObject<T: HandyJSON>(mapPath: String) -> AnyPublisher<[T], any Error> {
        self.map { String(data: $0, encoding: .utf8) }
            .map { JSONDeserializer<T>.deserializeModelArrayFrom(json: $0, designatedPath: mapPath)?.compactMap { $0 } }
            .replaceNil(with: [])
            .mapError {
                logger.error("\($0)")
                return $0
            }
            .eraseToAnyPublisher()
    }
}
