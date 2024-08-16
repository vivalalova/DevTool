//
//  File.swift
//
//
//  Created by Lova on 2024/5/23.
//

import MapKit

public
extension Comparable {
    func isBetween(_ low: Self, and high: Self) -> Bool {
        low < self && self < high
    }
}
