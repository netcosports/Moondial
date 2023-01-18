//
//  SampleShimmerController1.swift
//  Demo
//
//  Created by Dzianis Shykunets on 17.01.23.
//

import UIKit
import Alidade
import RxSwift
import Moondial
import PinLayout

class SampleShimmerController1: UIViewController, UIGestureRecognizerDelegate {
    
    private let shimmerView1 = ShimmerDemoView()
    private let shimmerView2 = ShimmerDemoView()
    
    private lazy var shimmerView = ShimmerView(shimmers: {
        shimmerView2.shimmers
    })
    
    private let realContentView = UIView() // required
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.view.addSubviews(shimmerView1, shimmerView)
        shimmerView.addSubviews(shimmerView2)
        shimmerView.set(realContentView: realContentView)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(300)) {
            self.shimmerView.startShimmer()
        }
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        shimmerView1.pin.top(self.view.safeAreaInsets.top + 40.ui).horizontally(10.ui)
            .height(60.ui)
        
        shimmerView.pin.below(of: shimmerView1).marginTop(20.ui).horizontally(10.ui)
            .height(60.ui)
    }
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

class ShimmerDemoView: UIView, ShimmersContainer {
    
    private let logo = UIImageView()
    private let text = UILabel {
        $0.textColor = .black
    }
    
    private let text2 = UILabel {
        $0.textColor = .black
    }
    
   
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubviews(logo, text, text2)
        logo.backgroundColor = .random
        text.text = "Demo Text!!!"
        text2.text = "Text to Hide"
        self.layer.borderColor = UIColor.magenta.cgColor
        self.layer.borderWidth = 2.ui
        self.layer.cornerRadius = 10.ui
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        logo.pin.top(10.ui).start(20.ui).size(40.ui)
        text.pin.after(of: logo).vCenter(to: logo.edge.vCenter).marginStart(10.ui).sizeToFit()
        text2.pin.end(10.ui).vCenter().sizeToFit()
    }
    
    var shimmers: [ShimmerSettings] {
       return [
        logo.shimmer(style: .transparent).width(40.ui).height(40.ui),
        text.shimmer(style: .transparent)
       ]
    }
    
}
