//
//  ColorGroup.swift
//  Pods
//
//  Created by Tatsuya Tobioka on 2017/05/20.
//
//

import Foundation

public struct ColorGroup {
    public let name: String
    public let mainColorIndex: Int
    public let items: [ColorItem]

    public var mainColor: ColorItem {
        return items[mainColorIndex]
    }

    public func contains(color: UIColor?) -> Bool {
        guard let color = color else { return false }
        return items.map { $0.color }.contains(color)
    }
}
