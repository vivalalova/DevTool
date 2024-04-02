//
//  String+generic.swift
//
//  Created by Lova on 2024/3/29.
//

import UIKit

precedencegroup AdditiveOptional {
    associativity: left
    higherThan: AssignmentPrecedence
}

infix operator +?: AdditiveOptional
infix operator +??: AdditiveOptional

public
extension String {
    static func +? (lhs: String, rhs: String?) -> String {
        let rhs = rhs ?? ""
        return lhs + rhs
    }

    static func +?? (lhs: String, rhs: String?) -> String? {
        guard let rhs = rhs else {
            return nil
        }
        return lhs + rhs
    }
}

public
extension String {
    func height(width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)

        return ceil(boundingBox.height)
    }

    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)

        return ceil(boundingBox.width)
    }
}

public
extension String {
    var QRCodeImage: UIImage? {
        let filter = CIFilter(name: "CIQRCodeGenerator")
        filter?.setValue(data(using: .utf8), forKey: "inputMessage")
        guard let image = filter?.outputImage else {
            return nil
        }

        return UIImage(ciImage: image)
    }
}

public extension NSAttributedString {
    static func + (left: NSAttributedString, right: NSAttributedString) -> NSAttributedString {
        let leftCopy = NSMutableAttributedString(attributedString: left)
        leftCopy.append(right)
        return leftCopy
    }
}
