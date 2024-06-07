//
//  HandyJSON+Transform.swift
//
//  Created by Lova on 2023/6/16.
//

import Foundation
import SmartCodable
import UIKit

public
final class TimestampSince1970Transform: ValueTransformable {
    public typealias Object = Date
    public typealias JSON = String

    public init() {}

    public func transformFromJSON(_ value: Any?) -> Date? {
        guard let unixTime = value as? Double else {
            return nil
        }
        return Date(timeIntervalSince1970: unixTime)
    }

    public func transformToJSON(_ value: Date?) -> String? {
        guard let value else {
            return nil
        }

        return String(value.timeIntervalSince1970)
    }
}
