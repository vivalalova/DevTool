//
//  Feedback.swift
//
//  Created by Lova on 2024/3/29.
//

import AVFoundation
import UIKit

public
final class Feedback {
    public static let shared = Feedback()

    public lazy var impact: UIImpactFeedbackGenerator = {
        let imp = UIImpactFeedbackGenerator(style: .medium)
        imp.prepare()
        return imp
    }()

    public func ding() {
        AudioServicesPlaySystemSound(1309)
    }
}
