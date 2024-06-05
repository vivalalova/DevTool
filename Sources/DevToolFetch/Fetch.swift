//
//  API.swift
//
//  Created by Lova on 2019/11/6.
//

import Combine
import Foundation

public
enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

public
protocol Fetch: AnyObject {
    typealias Params = [String: Any]

    var domain: String { get }

    static var shared: Self { get }

    func willSend(params: inout Params, method: HttpMethod, path: String) -> Params
    func willSend(request: inout URLRequest, method: HttpMethod, path: String, params: Params) -> URLRequest

    func show(progress: Float?)
    func hide(progress: Float?)

    /// called on all requests fail
    func on(_ error: URLError, of: URLRequest, isShow: Bool)
}
