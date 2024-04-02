//
//  Env.swift
//
//  Created by Lova on 2024/3/29.
//

import SwiftUI

public
typealias Closure<T> = (T) -> Void

public
extension EnvironmentValues {
    var closureBoolKey: Closure<Bool> {
        get { self[ClosureBoolKey.self] }
        set { self[ClosureBoolKey.self] = newValue }
    }

    struct ClosureBoolKey: EnvironmentKey {
        public
        static let defaultValue: Closure<Bool> = { _ in }
    }
}
