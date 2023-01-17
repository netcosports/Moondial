//
//  UIView+extensions.swift
//  Demo
//
//  Created by Dzianis Shykunets on 17.01.23.
//

import UIKit

extension UIView {

  var height: CGFloat { return frame.height }
  var width: CGFloat { return frame.width }

  // swiftlint:disable identifier_name
  var x: CGFloat { return frame.minX }
  var y: CGFloat { return frame.minY }
  // swiftlint:enable identifier_name

  func addSubviews(_ subviews: [UIView]) {
    subviews.forEach {
      addSubview($0)
    }
  }

  func addSubviews(_ subviews: UIView...) {
    subviews.forEach {
      addSubview($0)
    }
  }
}
