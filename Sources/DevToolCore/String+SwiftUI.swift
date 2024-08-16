//
//  File.swift
//
//
//  Created by Lova on 2024/6/1.
//

import Foundation
import SwiftUI

public
extension String {
    var text: Text {
        Text(self)
    }
}

extension String: View {
    public
    var body: some View {
        Text(self)
    }
}
