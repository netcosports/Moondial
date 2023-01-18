//
//  ShimmerView.swift
//  Moondial
//
//  Created by Dzianis Shykunets on 17.01.23.
//

import UIKit


public class ShimmerView: UIView {
    
    private let shimmer = Shimmer()
    fileprivate let shimmers: [ShimmerSettings]
    fileprivate var realContent: UIView?
    
    public init(@ShimmerBuilder shimmers: () -> [ShimmerConvertible]) {
        self.shimmers = shimmers().flatMap { $0.asShimmers() }
        super.init(frame: .zero)
        setup()
    }
    
    public convenience init() {
        self.init(frame: CGRect.zero)
    }
    
    public required override init(frame: CGRect) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    open func setup() {
        clipsToBounds = true
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        self.realContent?.frame = self.bounds
        guard realContent?.alpha == 0.0 else { return }
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(300)) {
            self.shimmer.handleBoundChange(self.shimmers, rootView: self)
        }
    }
    
    public func set(realContentView: UIView) {
        self.realContent = realContentView
        self.subviews.forEach { $0.alpha = 0.0 }
        self.addSubview(realContentView)
    }
    
    public func startShimmer() {
        guard realContent?.alpha == 1.0 else { return }
        self.subviews.forEach { $0.alpha = 1.0 }
        realContent?.alpha = 0.0
        shimmer.coverSubviews(shimmers, rootView: self)
    }
    
    public func stopShimmer() {
        guard realContent?.alpha == 0.0 else { return }
        UIView.animate(withDuration: 0.22, animations: {
            self.subviews.forEach {
                $0.alpha = self.realContent == $0 ? 1.0 : 0.0
            }
        }) { _ in
            self.shimmer.removeSubviews(self.shimmers, rootView: self)
        }
    }
}

extension ShimmerView {
    
    func subshimmers() -> ShimmerSettings {
        return ShimmerSettings(views: [self], style: .opaque).subshimmers(self.shimmers)
    }
}

class GradientShimerView: UIView {
    
    override class var layerClass: AnyClass {
        return CAGradientLayer.self
    }
    
    var colorLayer: CAGradientLayer? {
        self.layer as? CAGradientLayer
    }
}
