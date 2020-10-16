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
        UIView.animate(withDuration: 0.5, animations: {
            switch shouldAppear{
            case true:
                self.isHidden = !shouldAppear
                self.alpha = 1
            case false:
                self.isHidden = shouldAppear
                self.alpha = 0
            }
        }, completion:  { _ in
            switch shouldAppear{
            case true:
                self.alpha = 1
            case false:
                self.alpha = 0
            }
        })
    }
    
    func shouldUpdateCPUCard(_ shouldAppear:Bool){
        UIView.animate(withDuration: 0.5, animations: {
            switch shouldAppear{
            case true:
                self.alpha = 1
            case false:
                self.alpha = 0
            }
        }, completion:  { _ in
            switch shouldAppear{
            case true:
                self.alpha = 1
            case false:
                self.alpha = 0
            }
        })
    }
}
