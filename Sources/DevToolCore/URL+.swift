//
//  File.swift
//
//
//  Created by Lova on 2024/5/29.
//

import SwiftUI

public
extension URL {
    var toRequest: URLRequest {
        URLRequest(url: self)
    }
}
