//
//  ShimerDemoView2.swift
//  Demo
//
//  Created by Dzianis Shykunets on 25.01.23.
//

import UIKit
import Moondial

class ShimmerDemoView2: UIView, ShimmersContainer {
    
    private let child1 = UILabel()
    private let child2 = ShimmerDemo2InnerView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var shimmers: [ShimmerSettings] {
      [
        [child1.shimmer(style: .transparent)],
        child2.shimmers
      ].flatMap { $0 }
    }
    
    private func setup() {
        self.addSubviews(child1, child2)
        child1.textColor = .black
        child1.text = "Title"
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        child1.pin.top().start(10.ui).sizeToFit()
        child2.pin.below(of: child1).horizontally().height(60.ui)
    }
    
}


class ShimmerDemo2InnerView: UIView, ShimmersContainer {
    
    let imageView = UIView()
    let text = UILabel()
    
    var shimmers: [ShimmerSettings] {
        [
            imageView.shimmer(style: .transparent).size(30.ui),
            text.shimmer(style: .transparent)
        ]
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        imageView.backgroundColor = .random
        text.textColor = .black
        text.text = "Test text"
        self.addSubviews(imageView, text)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.pin.vCenter().size(30.ui).start(10.ui)
        text.pin.vCenter(to: imageView.edge.vCenter).after(of: imageView).marginStart(20.ui).sizeToFit()
    }
}
