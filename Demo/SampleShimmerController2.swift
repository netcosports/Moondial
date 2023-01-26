//
//  SampleShimmerController2.swift
//  Demo
//
//  Created by Dzianis Shykunets on 26.01.23.
//

import UIKit
import Moondial

class SampleShimmerController2: UIViewController, UIGestureRecognizerDelegate {
    
    private let demoView1 = ShimmerDemoView2()
    private let demoView2 = ShimmerDemoView2()
    
    private lazy var shimmerView = ShimmerView(shimmers: {
        demoView2.shimmers
    })
    
    private let realContentView = UIView() // required
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .yellow
        
        self.view.addSubviews(demoView1, shimmerView)
        shimmerView.addSubviews(demoView2)
        shimmerView.set(realContentView: realContentView)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(200)) {
            self.shimmerView.startShimmer()
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        demoView1.pin.top(50.ui).horizontally().height(120.ui)
        shimmerView.pin.below(of: demoView1).marginTop(20.ui).horizontally().height(120.ui)
        demoView2.pin.all()
    }
}
