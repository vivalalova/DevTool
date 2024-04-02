//
//  UIApplication+.swift
//
//  Created by Lova on 2024/3/29.
//

import UIKit

public
extension UIApplication {
    func open(url: String) {
        guard let url = URL(string: url) else {
            return
        }

        self.open(url)
    }
}
