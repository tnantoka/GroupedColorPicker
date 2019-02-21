//
//  ColorItemCell.swift
//  Pods
//
//  Created by Tatsuya Tobioka on 2017/05/23.
//
//

import UIKit

open class ColorItemCell: UITableViewCell {

    let borderView = UIView()

    var isBorderHidden = false {
        didSet {
            borderView.isHidden = isBorderHidden
        }
    }

    var item: ColorItem? {
        didSet {
            guard let item = item else { return }
            textLabel?.text = item.hexString
            textLabel?.textColor = item.textColor
            backgroundColor = item.color

            borderView.backgroundColor = item.textColor
            borderView.frame.size = CGSize(width: 4.0, height: contentView.bounds.height)
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(borderView)
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
