//
//  CollectionViewReusableView+Extension.swift
//  TDD_Practice_Poker
//
//  Created by kohei yoshida on 2020/10/12.
//

import Foundation
import UIKit

extension UICollectionReusableView{
    
    static var identifier: String{
        return className
    }
}

extension UICollectionViewLayout{
    
    static var identifier: String{
        return className
    }
}

