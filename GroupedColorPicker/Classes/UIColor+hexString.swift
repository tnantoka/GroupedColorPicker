//
//  UIColor+hexString.swift
//  Pods
//
//  Created by Tatsuya Tobioka on 2017/05/20.
//
//

import UIKit

extension UIColor {
    convenience init(hexString: String) {
        let components = UIColor.parseComponents(hexString: hexString)
        self.init(red: components[0], green: components[1], blue: components[2], alpha: 1.0)
    }

    static func parseComponents(hexString: String) -> [CGFloat] {
        let trimmed = hexString.trimmingCharacters(in: .whitespacesAndNewlines)
            .replacingOccurrences(of: "#", with: "")

        let substrings: [String] = stride(from: 0, to: 6, by: 2).map {
            let index = { trimmed.index(trimmed.startIndex, offsetBy: $0) }
            return String(trimmed[index($0)..<index($0 + 2)])
        }
        let components = substrings
            .map { Int($0, radix: 16) ?? 0 }
            .map { CGFloat($0) / 255.0 }

        return components
    }
}
