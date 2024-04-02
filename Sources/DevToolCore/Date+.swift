//
//  Date+.swift
//
//  Created by Lova on 2024/3/29.
//

import UIKit

public
extension Date {
    func formatted(_ format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        let formattedTime = dateFormatter.string(from: self)

        return formattedTime
    }
}
