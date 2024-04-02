//
//  ScrollOnOverflowView.swift
//  test
//
//  Created by Lova on 2023/3/29.
//

import SwiftUI

public
struct CGSizePreferenceKey: PreferenceKey {
    public
    typealias T = CGSize

    public
    static var defaultValue: T = .zero

    public
    static func reduce(value: inout T, nextValue: () -> T) {
        value = nextValue()
    }
}

public
extension View {
    /// 用CGSizePreferenceKey取得當下Size
    func onSizeChange(_ change: @escaping (CGSize) -> Void) -> some View {
        self
            .background(
                GeometryReader {
                    Color.clear.preference(
                        key: CGSizePreferenceKey.self,
                        value: $0.frame(in: .local).size
                    )
                }
                .onPreferenceChange(CGSizePreferenceKey.self) { size in
                    change(size)
                }
            )
    }

    /// 用CGSizePreferenceKey取得當下Size
    func onSizeChange(_ binder: Binding<CGSize>) -> some View {
        self
            .background(
                GeometryReader {
                    Color.clear.preference(
                        key: CGSizePreferenceKey.self,
                        value: $0.frame(in: .local).size
                    )
                }
                .onPreferenceChange(CGSizePreferenceKey.self) { size in
                    binder.wrappedValue = size
                }
            )
    }

    /// just print
    func onSizeChangePrint(_ prefix: String = "") -> some View {
        #if DEBUG
        self.onSizeChange { print(prefix, $0) }
        #else
        self
        #endif
    }
}

public
struct CGRectPreferenceKey: PreferenceKey {
    public typealias T = CGRect

    public static var defaultValue: T = .init()

    public static func reduce(value: inout T, nextValue: () -> T) {
        value = nextValue()
    }
}

public
extension View {
    func onFrameChange(coordinateSpace: CoordinateSpace, change: @escaping (CGRect) -> Void) -> some View {
        self
            .background(
                GeometryReader {
                    Color.clear.preference(
                        key: CGRectPreferenceKey.self,
                        value: $0.frame(in: coordinateSpace)
                    )
                }
                .onPreferenceChange(CGRectPreferenceKey.self) { rect in
                    change(rect)
                }
            )
    }
}

/// ScrollOnOverflowView
///
/// 用內容的高度來限制ScrollView的最大高度
///
/// 目的是內縮優先, 避免ScrollView擴展高度
/// 在內容太長(高)的時候才會Scroll
///
public
struct ScrollOnOverflowView<Content: View>: View {
    @State var height: CGFloat = 0

    /// True or False 可控制, nil則放棄
    @Binding var isScrollDisabled: Bool?

    @ViewBuilder var content: () -> Content

    public
    var body: some View {
        GeometryReader { p in
            ScrollView {
                self.content()
                    .onSizeChange { size in
                        self.height = size.height
                    }
            }
            .scrollDisabled(self.isScrollDisabled ?? (p.size.height > self.height))
        }
        .frame(maxHeight: self.height)
    }
}

public
extension View {
    /// 封裝 ScrollOnOverflowView
    func scrollOnOverflow(isScrollDisabled: Binding<Bool?> = .constant(nil)) -> some View {
        ScrollOnOverflowView(isScrollDisabled: isScrollDisabled) { self }
    }
}
