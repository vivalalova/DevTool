//
//  File.swift
//
//
//  Created by Lova on 2024/5/30.
//

import SwiftUI

public
protocol PopupMessage: Identifiable, View {
    var id: String { get }
}

@MainActor
public
final class Popup: ObservableObject {
    /// View level
    @Published var messages: [any PopupMessage] = []

    /// window Level , ex for alert
    @Published var windowMessages: [any PopupMessage] = []

    func show(message: any PopupMessage) {
        self.messages.append(message)
    }

    func show(windowMessage: any PopupMessage) {
        self.windowMessages.append(windowMessage)
    }
}

public
extension View {
    @MainActor
    func popupHandler() -> some View {
        ZStack {
            self
            ViewLevelView()
        }
        .environmentObject(Popup())
    }
}

private
struct ViewLevelView: View {
    @EnvironmentObject var popup: Popup

    var body: some View {
        Color.clear
            .ignoresSafeArea(.all)
            .overlay {
                if let view = popup.messages.first {
                    AnyView(view)
                }
            }
    }
}

extension Popup {
    func showCover(content: () -> any PopupMessage) {
        self.messages.append(content())
    }
}
