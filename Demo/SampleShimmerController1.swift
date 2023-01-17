//
//  SampleShimmerController1.swift
//  Demo
//
//  Created by Dzianis Shykunets on 17.01.23.
//

import UIKit
import Alidade
import RxSwift

class SampleShimmerController1: UIViewController, UIGestureRecognizerDelegate {
    
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
