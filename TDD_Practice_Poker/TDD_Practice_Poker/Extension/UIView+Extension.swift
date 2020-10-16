//
//  UIView+Extension.swift
//  TDD_Practice_Poker
//
//  Created by kohei yoshida on 2020/10/16.
//

import Foundation
import UIKit

extension UIView{
    func shouldAppearAnimationView(_ shouldAppear:Bool){
        UIView.animate(withDuration: 2, animations: {
            switch shouldAppear{
            case true:
                self.isHidden = !shouldAppear
                self.alpha = 0.5
            case false:
                self.isHidden = shouldAppear
                self.alpha = 0
            }
        }, completion:  { _ in
            switch shouldAppear{
            case true:
                self.alpha = 0.5
            case false:
                self.alpha = 0
            }
        })
    }
}
