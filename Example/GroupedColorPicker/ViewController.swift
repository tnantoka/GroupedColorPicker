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

    var pickerForModal: GroupedColorPickerViewController {
        let pickerController = GroupedColorPickerViewController()
        pickerController.didSelect = { [weak self] color, hexString in
            self?.view.backgroundColor = color
            self?.title = hexString
            self?.dismiss(animated: true, completion: nil)
        }
        pickerController.didClose = { [weak self] in
            self?.dismiss(animated: true, completion: nil)
        }
        pickerController.selectedColor = view.backgroundColor
        return pickerController
    }

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
        let pushInModalItem = UIBarButtonItem(
            title: NSLocalizedString("Push in Modal", comment: ""),
            style: .plain,
            target: self,
            action: #selector(pushInModal)
        )
        let flexibleItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)

        toolbarItems = [flexibleItem, modalItem, flexibleItem, pushItem, flexibleItem, pushInModalItem, flexibleItem]
        navigationController?.isToolbarHidden = false
    }

    // MARK: - Actions

    @objc func modal(sender: Any?) {
        let pickerController = pickerForModal

        let navController = UINavigationController(rootViewController: pickerController)
        navController.modalPresentationStyle = .formSheet

        present(navController, animated: true, completion: nil)
    }

    @objc func push(sender: Any?) {
        let pickerController = GroupedColorPickerViewController()
        pickerController.didSelect = { [weak self] color, hexString in
            self?.view.backgroundColor = color
            self?.title = hexString
            self?.navigationController?.popToRootViewController(animated: true)
        }
        pickerController.selectedColor = view.backgroundColor
        navigationController?.pushViewController(pickerController, animated: true)
    }

    @objc func pushInModal(sender: Any?) {
        let pickerController = pickerForModal

        let navController = UINavigationController(rootViewController: UIViewController())
        navController.modalPresentationStyle = .formSheet

        present(navController, animated: true) {
            _ = pickerController.view
            navController.pushViewController(pickerController, animated: true)
        }
    }
}
