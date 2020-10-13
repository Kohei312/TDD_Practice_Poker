//
//  NSObjectProtocol+Extension.swift
//  TDD_Practice_Poker
//
//  Created by kohei yoshida on 2020/10/12.
//

import Foundation
import UIKit

extension NSObjectProtocol{
    
    static var className: String{
        return String(describing: self)
    }
    
}

