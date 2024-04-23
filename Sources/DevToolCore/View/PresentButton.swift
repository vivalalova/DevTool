//
//  Button+.swift
//
//  Created by Lova on 2024/3/29.
//

import SwiftUI

/// 把State藏起來, 省得到處宣告
@available(iOS 16.4, *)
public
struct PresentButton<Content: View, Sheet: View>: View {
    @State var isPresented = false

    var adaptation: PresentationAdaptation
    @ViewBuilder var content: () -> Content
    @ViewBuilder var sheet: () -> Sheet

    @available(iOS 16.4, *)
    public
    init(_ adaptation: PresentationAdaptation, @ViewBuilder content: @escaping () -> Content, @ViewBuilder sheet: @escaping () -> Sheet) {
        self.adaptation = adaptation
        self.content = content
        self.sheet = sheet
    }

    public
    var body: some View {
        Button {
            self.isPresented = true
        } label: {
            self.content()
        }
        .sheet(isPresented: self.$isPresented) {
            self.sheet()
                .presentationCompactAdaptation(horizontal: self.adaptation, vertical: self.adaptation)
        }
//        .popover(isPresented: self.$isPresented) {
//            self.sheet()
//                .presentationCompactAdaptation(horizontal: self.adaptation, vertical: self.adaptation)
//        }
    }
}

@available(iOS 16.4, *)
extension PresentationAdaptation: Identifiable {
    public var id: String {
        String(describing: self)
    }
}

@available(iOS 16.4, *)
#Preview {
    VStack(spacing: 20) {
        let adaptations: [PresentationAdaptation] = [.fullScreenCover, .popover, .sheet]

        ForEach(adaptations) { a in
            PresentButton(a) {
                Text(a.id)
            } sheet: {
//                NavigationView {
                Text("sheet")
//                        .navigationTitle("nav")
//                }
            }
        }
    }
}
