//
//  Notification+Publisher.swift
//
//  Created by Lova on 2024/3/29.
//
import Foundation

public
extension Notification.Name {
    /// 直接使用 Notification.Name
    ///
    /// Example:
    ///
    /// ```
    /// UIApplication.didReceiveMemoryWarningNotification
    ///     .publisher
    ///     .sink { _ in }
    /// ```
    ///
    var publisher: NotificationCenter.Publisher {
        NotificationCenter.default.publisher(for: self)
    }
}
