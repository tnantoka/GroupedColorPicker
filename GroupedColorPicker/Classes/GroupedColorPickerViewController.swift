//
//  GroupedColorPickerViewController.swift
//  Pods
//
//  Created by Tatsuya Tobioka on 2017/05/20.
//
//

import UIKit

open class GroupedColorPickerViewController: UIViewController {

    fileprivate let reuseIdentifier = "Cell"

    open var didClose: (() -> Void)?
    open var didSelect: (UIColor) -> Void = { _ in }

    open var groups = GroupedColorPicker.materialDesignGroups
    open var group: ColorGroup! {
        didSet {
            title = group.name
        }
    }

    lazy open var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: self.reuseIdentifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        self.view.addSubview(collectionView)

        let length = self.view.bounds.width / ceil(CGFloat(self.groups.count) / 2.0)
        layout.itemSize = CGSize(width: length, height: length)
        layout.minimumLineSpacing = 0.0
        layout.minimumInteritemSpacing = 0.0

        collectionView.translatesAutoresizingMaskIntoConstraints = false
        let views: [String: Any] = [
            "collectionView": collectionView,
            "tableView": self.tableView,
            "topLayoutGuide": self.topLayoutGuide,
            "bottomLayoutGuide": self.bottomLayoutGuide

        ]
        let metrics = [
            "height": length * 2.0
        ]
        let vertical = NSLayoutConstraint.constraints(
            withVisualFormat: "V:[topLayoutGuide][collectionView(height)][tableView][bottomLayoutGuide]",
            options: [],
            metrics: metrics,
            views: views
        )
        let horizontal = NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-0-[collectionView]-0-|",
            options: [],
            metrics: nil,
            views: views
        )
        NSLayoutConstraint.activate(vertical + horizontal)

        return collectionView
    }()
    lazy open var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        self.view.addSubview(tableView)

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: self.reuseIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorColor = .clear
        tableView.backgroundColor = .clear

        tableView.translatesAutoresizingMaskIntoConstraints = false
        let views = [
            "tableView": tableView
        ]
        let horizontal = NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-0-[tableView]-0-|",
            options: [],
            metrics: nil,
            views: views
        )
        NSLayoutConstraint.activate(horizontal)

        return tableView
    }()

    override open func viewDidLoad() {
        super.viewDidLoad()

        if didClose != nil {
            let closeItem = UIBarButtonItem(
                title: GroupedColorPicker.localizedString("Close"),
                style: .plain,
                target: self,
                action: #selector(closeItemDidTap)
            )
            navigationItem.leftBarButtonItem = closeItem
        }

        view.backgroundColor = UIColor(hexString: "#FAFAFA")
        automaticallyAdjustsScrollViewInsets = false

        group = groups[0]

        _ = collectionView
    }

    // MARK: - Actions

    func closeItemDidTap(sender: Any?) {
        didClose?()
    }

    // MARK: - Utilities

    func focus(contentView: UIView, backgroundColor: UIColor) {
        let overlayView = UIView(frame: contentView.bounds)
        overlayView.backgroundColor = backgroundColor
        contentView.addSubview(overlayView)
        overlayView.alpha = 0.3
        UIView.animate(
            withDuration: 0.3,
            animations: {
                overlayView.alpha = 0.0
            }
        ) { _ in
            overlayView.removeFromSuperview()
        }
    }
}

extension GroupedColorPickerViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView,
                               cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        cell.backgroundColor = groups[indexPath.row].mainColor.color
        return cell
    }

    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groups.count
    }

    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) else { return }
        focus(contentView: cell.contentView, backgroundColor: group.mainColor.textColor)
        group = groups[indexPath.row]
        tableView.reloadData()
    }
}

extension GroupedColorPickerViewController: UITableViewDataSource, UITableViewDelegate {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return group.items.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        let item = group.items[indexPath.row]
        cell.textLabel?.text = item.hexString
        cell.textLabel?.textColor = item.textColor
        cell.backgroundColor = item.color
        cell.selectionStyle = .none
        return cell
    }

    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) else { return }
        let item = group.items[indexPath.row]
        focus(contentView: cell.contentView, backgroundColor: item.textColor)
        didSelect(item.color)
    }
}
