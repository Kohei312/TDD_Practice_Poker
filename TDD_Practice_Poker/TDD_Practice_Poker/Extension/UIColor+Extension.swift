//
//  UIColor+Extension.swift
//  TDD_Practice_Poker
//
//  Created by kohei yoshida on 2020/10/12.
//

import Foundation
import UIKit

extension UIColor{
    func cellColor(_ indexPath:IndexPath)->UIColor{
        
        guard var color:UIColor = UIColor(named: "Purple/Lightest") else {return UIColor()}
        
        switch indexPath.item{
        case 0:
            if let lightest = UIColor(named: "Purple/Lightest"){
                color = lightest
            }
        case 1:
            if let lighter = UIColor(named: "Purple/Lighter"){
                color = lighter
            }
        case 2:
            if let middle = UIColor(named: "Purple/Middle"){
                color = middle
            }
        case 3:
            if let deeper = UIColor(named: "Purple/Deeper"){
                color = deeper
            }
        case 4:
            if let deepest = UIColor(named: "Purple/Deepest"){
                color = deepest
            }
        default:
            return color
        }

        
        return color
    }
    
    func changedCellColor()->UIColor{
        
        guard var color:UIColor = UIColor(named: "Purple/Deepest") else {return UIColor()}
        return color
        
    }
}
