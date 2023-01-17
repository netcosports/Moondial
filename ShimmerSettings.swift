//
//  ShimmerSettings.swift
//  Moondial
//
//  Created by Dzianis Shykunets on 17.01.23.
//


import UIKit

public enum ShimmerStyle {
    case opaque
    case transparent
    case hidden // hide view when shimmering
}

public enum ShimmerAlignment {
    case start
    case end
    case center
}

protocol Shimmerable {
    
    var views: [UIView] { get }
    var style: ShimmerStyle { get }
    
    var cornerRadius: CGFloat? { get }
    var height: CGFloat? { get }
    var width: CGFloat? { get }
    var hAlignment: ShimmerAlignment? { get }
    var vAlignment: ShimmerAlignment? { get }
    
    var customShape: ((CGRect) -> (UIBezierPath))? { get }
    
    var subshimmers: [Shimmerable] { get }
}

protocol ShimmerConvertible {
    func asShimmers() -> [ShimmerSettings]
}

extension ShimmerSettings: ShimmerConvertible {
    
    func asShimmers() -> [ShimmerSettings] {
        [self]
    }
}

extension Array: ShimmerConvertible where Element == ShimmerSettings {
    func asShimmers() -> [ShimmerSettings] { self }
}

@resultBuilder struct ShimmerBuilder {
    
    typealias Component = ShimmerConvertible
    
    static func buildBlock(_ components: ShimmerConvertible...) -> [ShimmerConvertible] {
        components
    }
}

public protocol ShimmersContainer {
    var shimmers: [ShimmerSettings] { get }
}

public class ShimmerSettings: Shimmerable {
    
    let views: [UIView]
    let style: ShimmerStyle
    
    init(views: [UIView], style: ShimmerStyle) {
        self.views = views
        self.style = style
    }
    
    public func width(_ value: CGFloat) -> ShimmerSettings {
        self.width = value
        return self
    }
    
    public func height(_ value: CGFloat) -> ShimmerSettings {
        self.height = value
        return self
    }
    
    public func cornerRadius(_ value: CGFloat) -> ShimmerSettings {
        self.cornerRadius = value
        return self
    }
    
    public func customShape(_ value: @escaping (CGRect) -> (UIBezierPath)) -> ShimmerSettings {
        self.customShape = value
        return self
    }
    
    public func vAlignment(_ value: ShimmerAlignment) -> ShimmerSettings {
        self.vAlignment = value
        return self
    }
    
    public func hAlignment(_ value: ShimmerAlignment) -> ShimmerSettings {
        self.hAlignment = value
        return self
    }
    
    func subshimmers( _ value: [Shimmerable]) -> ShimmerSettings {
        self.subshimmers = value
        return self
    }
    
    var height: CGFloat?
    var width: CGFloat?
    var cornerRadius: CGFloat?
    var hAlignment: ShimmerAlignment?
    var vAlignment: ShimmerAlignment?
    var customShape: ((CGRect) -> (UIBezierPath))?
    var subshimmers: [Shimmerable] = []
}

public extension UIView {
    func shimmer(style: ShimmerStyle) -> ShimmerSettings {
        return ShimmerSettings(views: [self], style: style)
    }
}

public extension Array where Element: UIView {
    func shimmer(style: ShimmerStyle) -> ShimmerSettings {
        return ShimmerSettings(views: self, style: style)
    }
}

