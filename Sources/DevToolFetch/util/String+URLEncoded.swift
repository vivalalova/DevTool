//
//  String+URLEncoded.swift
//
//  Created by Lova on 2020/3/1.
//

import Foundation

extension String {
    var urlEncoded: String {
        self.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
    }

    var urlDecoded: String {
        self.removingPercentEncoding ?? ""
    }
}
