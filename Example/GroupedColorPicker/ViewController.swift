//
//  ViewController.swift
//  GroupedColorPicker
//
//  Created by tnantoka on 05/20/2017.
//  Copyright (c) 2017 tnantoka. All rights reserved.
//

import UIKit

import GroupedColorPicker

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Grouped Color Picker"

        let modalItem = UIBarButtonItem(
            title: NSLocalizedString("Modal", comment: ""),
            style: .plain,
            target: self,
            action: #selector(modal)
        )
        let pushItem = UIBarButtonItem(
            title: NSLocalizedString("Push", comment: ""),
            style: .plain,
            target: self,
            action: #selector(push)
        )
        let flexibleItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)

        toolbarItems = [flexibleItem, modalItem, flexibleItem, pushItem, flexibleItem]
        navigationController?.isToolbarHidden = false
    }

    // MARK: - Actions

    func modal(sender: Any?) {
        let pickerController = GroupedColorPickerViewController()
        pickerController.didSelect = { [weak self] color, hexString in
            self?.view.backgroundColor = color
            self?.title = hexString
            self?.dismiss(animated: true, completion: nil)
        }
        pickerController.didClose = { [weak self] in
            self?.dismiss(animated: true, completion: nil)
        }
        let navController = UINavigationController(rootViewController: pickerController)
        present(navController, animated: true, completion: nil)
    }

    func push(sender: Any?) {
        let pickerController = GroupedColorPickerViewController()
        pickerController.didSelect = { [weak self] color, hexString in
            self?.view.backgroundColor = color
            self?.title = hexString
            self?.navigationController?.popToRootViewController(animated: true)
        }
        navigationController?.pushViewController(pickerController, animated: true)
    }
}
