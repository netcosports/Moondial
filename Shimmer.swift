//
//  Shimmer.swift
//  Moondial
//
//  Created by Dzianis Shykunets on 17.01.23.
//

import UIKit

class Shimmer: NSObject {

    //fixme discuss why it was private
  public override init() {}
  private var _viewCover: GradientShimerView?
  fileprivate var viewCover: GradientShimerView? {
    if _viewCover == nil {
      _viewCover = GradientShimerView()
      _viewCover?.alpha = 0.0
      _viewCover?.tag = 1024
      _viewCover?.backgroundColor = UIColor.clear
    }
    return _viewCover
  }
  private var maskLayer: CAShapeLayer?
  private var coverablePath: UIBezierPath?
  private var totalCoverablePath: UIBezierPath? {
    if coverablePath == nil {
      coverablePath = UIBezierPath()
    }
    return coverablePath
  }
  private var addOffsetflag = false
}

extension Shimmer {

  func removeSubviews(_ shimmers: [Shimmerable], rootView: UIView) {
    viewCover?.alpha = 0.0
    rootView.viewWithTag(1024)?.removeFromSuperview()
    shimmers.forEach { shimmer in
      shimmer.views.forEach { $0.alpha = 1.0 }
    }
  }

  func coverSubviews(_ shimmers: [Shimmerable], rootView: UIView) {
    viewCover?.frame = rootView.bounds
    coverablePath = nil
    viewCover?.alpha = 1.0
    shimmers.forEach { shimmer in
      buildCoverPath(for: shimmer, rootView: rootView)
    }
    if !shimmers.isEmpty {
      setupCoverView(into: rootView)
    }
  }

  func handleBoundChange(_ shimmers: [Shimmerable], rootView: UIView) {
    viewCover?.frame = rootView.bounds
    coverablePath = nil
    shimmers.forEach { shimmer in
      buildCoverPath(for: shimmer, rootView: rootView)
    }

    self.maskLayer?.path = totalCoverablePath?.cgPath
  }

  private func buildCoverPath(for shimmer: Shimmerable, rootView: UIView) {
    defer {
      shimmer.subshimmers.forEach {
        self.buildCoverPath(for: $0, rootView: rootView)
      }
    }
    switch shimmer.style {
      case .transparent:
        shimmer.views.forEach { $0.alpha = 0.0 }
      case .opaque:
        shimmer.views.forEach { $0.alpha = 1.0 }
      case .hidden:
        shimmer.views.forEach { $0.alpha = 0.0 }
        return
    }
    let bounds = shimmer.views.reduce(CGRect.zero) { result, view in
      if result.isEmpty {
        return view.bounds
      } else {
        return view.bounds.union(result)
      }
    }

    guard !bounds.isEmpty else { return }

    let localCoverPath: UIBezierPath
    if let customShape = shimmer.customShape?(bounds) {
      localCoverPath = customShape
    } else {
      let cornerRadius = shimmer.cornerRadius ?? 0.0
      let width = shimmer.width ?? bounds.width
      let height = shimmer.height ?? bounds.height

      let bounds = CGRect(origin: bounds.origin, size: CGSize(width: width, height: height))
      localCoverPath = UIBezierPath(
        roundedRect: bounds,
        cornerRadius: cornerRadius
      )
    }
    let relativePath: UIBezierPath = localCoverPath
    let offsetPoint: CGPoint = shimmer.views.first?.convert(bounds, to: rootView).origin ?? .zero
    shimmer.views.forEach { $0.layoutIfNeeded() }
    let customSizeX: CGFloat
    switch shimmer.hAlignment {
      case .none:
        customSizeX = 0.0
      case .start:
        customSizeX = 0.0
      case .center:
        customSizeX = 0.5 * (bounds.width - (shimmer.width ?? bounds.width))
      case .end:
        customSizeX = bounds.width - (shimmer.width ?? bounds.width)
    }
    let customSizeY: CGFloat
    switch shimmer.hAlignment {
      case .none:
        customSizeY = 0.5 * (bounds.height - (shimmer.height ?? bounds.height))
      case .start:
        customSizeY = 0.0
      case .center:
        customSizeY = 0.5 * (bounds.height - (shimmer.height ?? bounds.height))
      case .end:
        customSizeY = (bounds.height - (shimmer.height ?? bounds.height))
    }

    relativePath.apply(
      CGAffineTransform(translationX: offsetPoint.x + customSizeX, y: offsetPoint.y + customSizeY)
    )
    totalCoverablePath?.append(relativePath)
  }

  private func setupCoverView(into view: UIView?) {
    guard let viewCover = viewCover, let view = view else {
      return
    }
    view.addSubview(viewCover)
    guard let colorLayer = viewCover.colorLayer else {
      return
    }

    colorLayer.startPoint = CGPoint(x: -1.4, y: 0)
    colorLayer.endPoint = CGPoint(x: 1.4, y: 0)
    colorLayer.colors = [
      UIColor(red: 0, green: 0, blue: 0, alpha: 0.01).cgColor,
      UIColor(red: 0, green: 0, blue: 0, alpha: 0.1).cgColor,
      UIColor(red: 1, green: 1, blue: 1, alpha: 0.009).cgColor,
      UIColor(red: 0, green: 0, blue: 0, alpha: 0.04).cgColor,
      UIColor(red: 0, green: 0, blue: 0, alpha: 0.02).cgColor
    ]
    colorLayer.locations = [
      NSNumber(value: Double(colorLayer.startPoint.x)),
      NSNumber(value: Double(colorLayer.startPoint.x)),
      NSNumber(value: 0),
      NSNumber(value: 0.2),
      NSNumber(value: 1.2)
    ]
    if let targetBackgroundColor = viewCover.backgroundColor?.cgColor {
      colorLayer.backgroundColor = targetBackgroundColor
    } else {
      colorLayer.backgroundColor = UIColor.white.cgColor
    }

    setMaskPath()
    startAnimation()
  }

  private func setMaskPath() {
    let maskLayer = CAShapeLayer()
    maskLayer.path = totalCoverablePath?.cgPath
    maskLayer.fillColor = UIColor.red.cgColor
    self.maskLayer = maskLayer
    viewCover?.colorLayer?.mask = maskLayer
  }

  private func startAnimation() {
    guard let colorLayer = viewCover?.colorLayer else {
      return
    }
    let animation = CABasicAnimation(keyPath: "locations")
    animation.fromValue = colorLayer.locations
    animation.toValue = [NSNumber(value: 0), NSNumber(value: 1), NSNumber(value: 1), NSNumber(value: 1.2), NSNumber(value: 1.2)]
    animation.duration = 1.3
    animation.repeatCount = HUGE
    animation.isRemovedOnCompletion = false
    colorLayer.add(animation, forKey: "locations-layer")
  }
}




