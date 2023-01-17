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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .magenta
    }
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

class ShimmerDemoView: UIView, ShimmersContainer {
    
    private let logo = UIImageView()
    private let text = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubviews(logo, text)
        text.text = "Demo Text!!!"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        logo.pin.vCenter().start(20.ui)
        text.pin.after(of: logo).vCenter().marginStart(10.ui).sizeToFit(.width)
    }
    
    var shimmers: [ShimmerSettings] {
       return [
        logo.shimmer(style: .transparent).width(40.ui).height(40.ui),
        text.shimmer(style: .transparent)
       ]
    }
    
}
