//
//  Button+.swift
//
//  Created by Lova on 2024/3/29.
//

import SwiftUI

/// 把State藏起來, 省得到處宣告
public
struct PresentButton<Content: View, Sheet: View>: View {
    @State var isPresented = false

    @ViewBuilder var content: () -> Content
    @ViewBuilder var sheet: () -> Sheet

    public
    init(@ViewBuilder content: @escaping () -> Content, @ViewBuilder sheet: @escaping () -> Sheet) {
        self.content = content
        self.sheet = sheet
    }

    public
    var body: some View {
        Button(action: {
            self.isPresented = true
        }, label: {
            self.content()
        })
        .sheet(isPresented: self.$isPresented) {
            self.sheet()
        }
    }
}

#Preview {
    PresentButton {
        Text("press me")
    } sheet: {
        Text("sheet")
    }
}
