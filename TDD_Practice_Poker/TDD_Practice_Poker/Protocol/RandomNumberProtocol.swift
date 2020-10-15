//
//  RandomNumberProtocol.swift
//  TDD_Practice_Poker
//
//  Created by kohei yoshida on 2020/10/15.
//

import Foundation

protocol RandomNumberProtocol{
    func randomNumber(_ range:Range<UInt32>) -> Int
}

extension RandomNumberProtocol{
    func randomNumber(_ range:Range<UInt32>) -> Int{
        guard let first = range.first, let last = range.last else {return 0}
        let i = Int(arc4random_uniform(last - first) + first)
        return i
    }
}
