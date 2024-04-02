//
//  URL.swift
//
//  Created by Lova on 2019/12/25.
//

import Combine
import Foundation

extension URL: Identifiable {
    public var id: String {
        self.absoluteString
    }
}

extension URL {
    /// for GET method
    func addParameter(_ dict: [String: Any]) -> URL {
        let string = "\(self.absoluteString)?\(dict.queryParameters)"

        guard let url = URL(string: string) else {
            fatalError("url")
        }

        return url
    }
}
