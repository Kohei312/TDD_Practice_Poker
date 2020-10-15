//
//  CircleMenuButtonProperty.swift
//  TDD_Practice_Poker
//
//  Created by kohei yoshida on 2020/10/14.
//

import Foundation
import UIKit

struct CircleMenuButtonProperty{
    let items: [(icon: String, color: UIColor)] = [
        ("ButtonMenu/TurnOver", UIColor(red: 0.96, green: 0.23, blue: 0.21, alpha: 1)),
        ("ButtonMenu/TryBattle", UIColor(red: 0.22, green: 0.74, blue: 0, alpha: 1)),
//        ("ButtonMenu/ChangeCard", UIColor(red: 0.19, green: 0.57, blue: 1, alpha: 1)),
//        ("settings-btn", UIColor(red: 0.51, green: 0.15, blue: 1, alpha: 1)),
//        ("nearby-btn", UIColor(red: 1, green: 0.39, blue: 0, alpha: 1))
    ]
    var subButtonPosition: [CGPoint] = []
    
    mutating func setSubButtonPosition(frame:CGRect){
        subButtonPosition = [
            CGPoint(x: frame.midX, y: frame.midY),
            CGPoint(x: frame.minX - frame.width/2, y: frame.minY - frame.height/2)
        ]
    }
}
