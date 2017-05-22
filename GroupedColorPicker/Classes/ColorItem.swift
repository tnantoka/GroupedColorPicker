//
//  ColorItem.swift
//  Pods
//
//  Created by Tatsuya Tobioka on 2017/05/20.
//
//

import Foundation

public struct ColorItem {
    public let hexString: String

    public var color: UIColor {
        return UIColor(hexString: hexString)
    }

    public var textColor: UIColor {
        let components = UIColor.parseComponents(hexString: hexString)
        let luminance = components[0] * 0.2126 + components[1] * 0.7152 + components[2] * 0.0722

        return luminance > 0.6 ? UIColor(white: 0, alpha: 0.87) : UIColor.white
    }
}
