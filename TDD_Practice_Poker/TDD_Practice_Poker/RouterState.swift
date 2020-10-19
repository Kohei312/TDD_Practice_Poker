//
//  PokerRouterState.swift
//  TDD_Practice_Poker
//
//  Created by kohei yoshida on 2020/10/19.
//

import Foundation
import UIKit

public enum RouterState:String{
    
    case top = "Top"
    case main = "Main"
    
    public func initiateVC< VC: UIViewController >(_ viewController:VC.Type)->VC{
        let storyboard = UIStoryboard(name: self.rawValue, bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: viewController.identifier) as? VC else {
            fatalError("Cannot find\(self.rawValue) in any Storyboard")
        }
        return vc
    }
}
