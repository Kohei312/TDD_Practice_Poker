//
//  GameStateAnimationBaseView.swift
//  TDD_Practice_Poker
//
//  Created by kohei yoshida on 2020/10/15.
//

import UIKit

class GameStateAnimationBaseView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = .darkGray
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    
}
