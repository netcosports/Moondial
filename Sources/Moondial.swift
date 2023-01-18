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


public class MoondialSettings {
    
    static var shimmerColors: [CGColor] = [
        UIColor(red: 0, green: 0, blue: 0, alpha: 0.01).cgColor,
        UIColor(red: 0, green: 0, blue: 0, alpha: 0.1).cgColor,
        UIColor(red: 1, green: 1, blue: 1, alpha: 0.009).cgColor,
        UIColor(red: 0, green: 0, blue: 0, alpha: 0.04).cgColor,
        UIColor(red: 0, green: 0, blue: 0, alpha: 0.02).cgColor
    ]
    
    static var animationDuration = 1.3
    
    public static func set(shimmerColors: [CGColor]) {
        Self.shimmerColors = shimmerColors
    }
    
    public static func set(animationDurationInMillis: Double) {
        Self.animationDuration = animationDurationInMillis
    }
}
