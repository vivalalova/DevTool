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
    var double: Double? {
        Double(self)
    }
}

public
extension String {
    var text: Text {
        Text(self)
    }
}

extension String: @retroactive View {
    public
    var body: some View {
        Text(self)
    }
}
