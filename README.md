# GroupedColorPicker

[![CI Status](http://img.shields.io/travis/tnantoka/GroupedColorPicker.svg?style=flat)](https://travis-ci.org/tnantoka/GroupedColorPicker)
[![Version](https://img.shields.io/cocoapods/v/GroupedColorPicker.svg?style=flat)](http://cocoapods.org/pods/GroupedColorPicker)
[![License](https://img.shields.io/cocoapods/l/GroupedColorPicker.svg?style=flat)](http://cocoapods.org/pods/GroupedColorPicker)
[![Platform](https://img.shields.io/cocoapods/p/GroupedColorPicker.svg?style=flat)](http://cocoapods.org/pods/GroupedColorPicker)

![](/screenshot.png)

## Installation

```ruby
pod 'GroupedColorPicker'
```

## Usage

```swift
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
```

## Acknowledgements

- https://github.com/CodeCatalyst/MaterialDesignColorPicker
- https://github.com/ViccAlexander/Chameleon

## Author

[@tnantoka](https://twitter.com/tnantoka)

## License

MIT
