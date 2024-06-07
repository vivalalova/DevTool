//
//  Extension+Async.swift
//
//  Created by lova on 2024/1/11.
//

import Combine
import Foundation
import OSLog
import SmartCodable

// async
public
extension Fetch {
    @MainActor
    func callAsync(request: URLRequest, showHUD: Bool = false, showErrorMessage: Bool) async throws -> Data {
        if showHUD {
            self.show(progress: nil)
        }

        let (data, response) = try await URLSession.shared.data(for: request)

        return try self.afterRequest(data: data, showHUD: showHUD, response: response, request: request, showErrorMessage: showErrorMessage)
    }

    func fetchAsync(method: HttpMethod = .get, path: String, params: [String: Any] = [:], showHUD: Bool = false, showErrorMessage: Bool = false) async throws -> Data {
        let request = self.request(method: method, path: path, params: params, showHUD: showHUD, showErrorMessage: showErrorMessage)
        return try await self.callAsync(request: request, showHUD: showHUD, showErrorMessage: showErrorMessage)
    }
}

public
extension Fetch {
    func fetchAsync(method: HttpMethod = .get, path: String, params: [String: Any] = [:], showHUD: Bool = false, showErrorMessage: Bool = false) async throws -> String? {
        do {
            let data: Data = try await self.fetchAsync(method: method, path: path, params: params, showHUD: showHUD, showErrorMessage: showErrorMessage)
            return String(data: data, encoding: .utf8)
        } catch {
            logger.error("\(error)")
            throw error
        }
    }

    func fetchAsync(method: HttpMethod = .get, path: String, params: [String: Any] = [:], showHUD: Bool = false, showErrorMessage: Bool = false) async throws -> [String: Any]? {
        do {
            let data: Data = try await self.fetchAsync(method: method, path: path, params: params, showHUD: showHUD, showErrorMessage: showErrorMessage)
            return try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
        } catch {
            logger.error("\(error)")
            throw error
        }
    }

    func fetchAsync<T: SmartCodable>(method: HttpMethod = .get, path: String, params: [String: Any] = [:], showHUD: Bool = false, showErrorMessage: Bool = false, designatedPath: String? = nil) async throws -> [T] {
        do {
            let data: Data = try await self.fetchAsync(method: method, path: path, params: params, showHUD: showHUD, showErrorMessage: showErrorMessage)
            let string = String(data: data, encoding: .utf8)

            return [T].deserialize(from: string, designatedPath: designatedPath)?.compactMap { $0 } ?? []
        } catch {
            logger.error("\(error)")
            throw error
        }
    }

    func fetchAsync<T: SmartCodable>(method: HttpMethod = .get, path: String, params: [String: Any] = [:], showHUD: Bool = false, showErrorMessage: Bool = false, designatedPath: String? = nil) async throws -> T? {
        do {
            let data: Data = try await self.fetchAsync(method: method, path: path, params: params, showHUD: showHUD, showErrorMessage: showErrorMessage)
            let string = String(data: data, encoding: .utf8)
            
            return T.deserialize(from: string, designatedPath: designatedPath)
        } catch {
            logger.error("\(error)")
            throw error
        }
    }

    func fetchAsync(method: HttpMethod = .get, path: String, params: [String: Any] = [:], showHUD: Bool = false, showErrorMessage: Bool = false) async throws {
        do {
            let _: Data = try await self.fetchAsync(method: method, path: path, params: params, showHUD: showHUD, showErrorMessage: showErrorMessage)
        } catch {
            logger.error("\(error)")
            throw error
        }
    }
}
