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
        
        //
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(200)) {
            self.shimmerView.startShimmer()
        }
     //   self.shimmerView.startShimmer()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        shimmerView1.pin.top(self.view.safeAreaInsets.top + 40.ui).horizontally(10.ui)
            .height(230.ui)
        
        shimmerView.pin.below(of: shimmerView1).marginTop(20.ui).horizontally(10.ui)
            .height(230.ui)
        
        shimmerView2.pin.all()
    }
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

class ShimmerDemoView: UIView, ShimmersContainer {
    
    private let logo = UIImageView()
    private let logo2 = UIImageView()
    private let logo3 = UIImageView()
    private let text = UILabel {
        $0.textColor = .black
    }
    
    private let text2 = UILabel {
        $0.textColor = .black
    }
    
    private let text3 = UILabel {
        $0.textColor = .black
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubviews(logo, logo2, logo3, text, text2, text3)
        logo.backgroundColor = .random
        logo2.backgroundColor = .random
        logo3.backgroundColor = .random
        text.text = "Shimmer Text"
        text2.text = "Hide Text"
        text3.text = "Opaque Text"
        self.layer.borderColor = UIColor.magenta.cgColor
        self.layer.borderWidth = 2.ui
        self.layer.cornerRadius = 10.ui
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        logo.pin.vCenter().start(20.ui).size(40.ui)
        logo2.pin.below(of: logo).start(20.ui).marginTop(10.ui).width(40.ui).height(20.ui)
        logo3.pin.below(of: logo2).start(20.ui).marginTop(10.ui).width(40.ui).height(20.ui)
        text.pin.after(of: logo).vCenter(to: logo.edge.vCenter).marginStart(20.ui).sizeToFit()
        text3.pin.after(of: logo3).vCenter(to: logo3.edge.vCenter).marginStart(20.ui).sizeToFit()
        text2.pin.after(of: logo2).vCenter(to: logo2.edge.vCenter).marginStart(20.ui).sizeToFit()
    }
    
    var shimmers: [ShimmerSettings] {
       return [
        logo.shimmer(style: .transparent).width(40.ui).height(40.ui),
        logo2.shimmer(style: .transparent).customShape(ShimmerView.hexagonShaper),
        text.shimmer(style: .transparent),
        text2.shimmer(style: .hidden),
        text3.shimmer(style: .opaque)
       ]
    }
    
}
