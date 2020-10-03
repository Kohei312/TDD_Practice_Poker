//
//  Card.swift
//  TDD_Practice_Poker
//
//  Created by kohei yoshida on 2020/10/03.
//

import Foundation

extension Card{
    enum Rank:String{
        case ace = "A"
        case two = "2"
        case three = "3"
        case four = "4"
        case five = "5"
        case six = "6"
        case seven = "7"
        case eight = "8"
        case nine = "9"
        case ten = "10"
        case jack = "J"
        case queen = "Q"
        case king = "K"
    }
    
    enum Suit: String{
        case spade = "♠︎"
        case heart = "❤︎"
        case club = "♣︎"
        case diamond = "♦︎"
    }
}

struct Card:Equatable{
    let suit:Suit
    let rank:Rank
    
    // tips: ここがなくても動く...
//    static func ==(lhs: Card, rhs: Card) -> Bool {
//        return lhs.hasSameSuit(rhs) && lhs.hasSameRank(rhs)
//    }
    
    // 期待値をベタ書きする仮実装 → まずは成功パターンを作る!!
    var notify: String{
        return suit.rawValue + rank.rawValue
    }
    
    
    func hasSameSuit(_ card:Card)->Bool{
        // まずは期待値をベタ書きする仮実装 => OK
//        return true
        // つづいて一般化 => OK
        // tips: enumはequatableに準拠するため、等価比較ができる
        return self.suit == card.suit
    }
    
    func hasSameRank(_ card:Card)->Bool{
        // まずは期待値をベタ書きする仮実装 => OK
//        return true
        // つづいて一般化 => OK
        // tips: enumはequatableに準拠するため、等価比較ができる
        return self.rank == card.rank
    }
    
}
