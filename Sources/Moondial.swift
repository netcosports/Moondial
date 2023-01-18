//
//  Moondial.swift
//  Moondial
//
//  Created by Dzianis Shykunets on 17/01/23.
//  Copyright © 2023 Netcosports. All rights reserved.
//

import UIKit
import Astrolabe
import RxSwift
import RxCocoa


@objc public class MoondialSettings: NSObject {
    
    private override init() {}
    
    static var shimmerColors: [CGColor] = [
        UIColor(red: 0, green: 0, blue: 0, alpha: 0.01).cgColor,
        UIColor(red: 0, green: 0, blue: 0, alpha: 0.1).cgColor,
        UIColor(red: 1, green: 1, blue: 1, alpha: 0.009).cgColor,
        UIColor(red: 0, green: 0, blue: 0, alpha: 0.04).cgColor,
        UIColor(red: 0, green: 0, blue: 0, alpha: 0.02).cgColor
    ]
    
    
    @objc static func setShimmerColors(colors: [CGColor]) {
        Self.shimmerColors = colors
    }
    
    @objc static func setShimmerAnimationDuration(millis: Int) {
        
    }
}
