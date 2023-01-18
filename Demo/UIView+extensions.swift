//
//  UIView+extensions.swift
//  Demo
//
//  Created by Dzianis Shykunets on 17.01.23.
//

import UIKit
import Moondial

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

extension ShimmerView {

  static var hexagonShaper: (CGRect) -> UIBezierPath {
    return { rect in
      let offset: CGFloat = 10.ui
      let path = UIBezierPath()
      path.move(to: CGPoint(x: rect.minX, y: rect.midY))
      path.addLine(to: CGPoint(x: rect.minX + offset, y: rect.maxY))
      path.addLine(to: CGPoint(x: rect.maxX - offset, y: rect.maxY))
      path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
      path.addLine(to: CGPoint(x: rect.maxX - offset, y: rect.minY))
      path.addLine(to: CGPoint(x: rect.minX + offset, y: rect.minY))
      path.close()
      return path
    }
  }
}
