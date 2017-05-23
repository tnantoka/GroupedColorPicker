//
//  ColorGroupCell.swift
//  Pods
//
//  Created by Tatsuya Tobioka on 2017/05/23.
//
//

import UIKit

open class ColorGroupCell: UICollectionViewCell {

    let borderView = UIView()

    var isBorderHidden = false {
        didSet {
            borderView.isHidden = isBorderHidden
        }
    }

    var group: ColorGroup? {
        didSet {
            guard let group = group else { return }
            backgroundColor = group.mainColor.color

            borderView.layer.borderColor = group.mainColor.textColor.cgColor
            borderView.frame.size = contentView.bounds.size
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        borderView.layer.borderWidth = 2.0
        contentView.addSubview(borderView)
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
