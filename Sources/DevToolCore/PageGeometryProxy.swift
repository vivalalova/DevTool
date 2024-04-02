//
//  PageGeometryProxy.swift
//
//  Created by Lova on 2024/3/29.
//

import SwiftUI

public
extension EnvironmentValues {
    struct Proxy: Equatable {
        public let size: CGSize
        public let safeAreaInsets: EdgeInsets

        public
        init(_ proxy: GeometryProxy? = nil) {
            self.size = proxy?.size ?? .zero
            self.safeAreaInsets = proxy?.safeAreaInsets ?? .init()
        }
    }

    private struct ProxyKey: EnvironmentKey {
        static var defaultValue: Proxy = .init()
    }

    var pageGeometryProxy: Proxy {
        get { self[ProxyKey.self] }
        set { self[ProxyKey.self] = newValue }
    }

    struct GeometryProxyModifier: ViewModifier {
        public
        func body(content: Content) -> some View {
            GeometryReader { proxy in
                content
                    .environment(\.pageGeometryProxy, .init(proxy))
            }
        }
    }
}

public extension View {
    func pageGeometryProxy() -> some View {
        modifier(EnvironmentValues.GeometryProxyModifier())
    }
}
