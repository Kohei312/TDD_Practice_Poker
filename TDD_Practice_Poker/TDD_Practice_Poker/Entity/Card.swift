//
//  Card.swift
//  TDD_Practice_Poker
//
//  Created by kohei yoshida on 2020/10/03.
//

import Foundation

extension Card{
    enum Suit: String{
        case spade = "♠︎"
        case heart = "❤︎"
        case club = "♣︎"
        case diamond = "♦︎"
    }
    
    enum Rank:String,Comparable,CaseIterable{
        static func < (lhs: Card.Rank, rhs: Card.Rank) -> Bool {
            return lhs.index < rhs.index
        }
        
        var index:Int{
            return Card.Rank.allCases.firstIndex(of: self) ?? 0
        }
        
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
        case ace = "A"
        
    }
}

struct Card:Equatable,Hashable{
    
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
    
    
    func hasSameSuit(_ card:Card)->[Card]{
        // まずは期待値をベタ書きする仮実装 => OK
        //        return true
        // つづいて一般化 => OK
        // tips: enumはequatableに準拠するため、等価比較ができる
        
        //        return self.suit == card.suit
        
        var sameSuitCards:[Card] = []
        
        
        if self.suit == card.suit{
            sameSuitCards = [self,card]
        }
        
        
        // 仮実装OK
        return sameSuitCards
    }
    
    func hasSameRank(_ card:Card)->Bool{
        // まずは期待値をベタ書きする仮実装 => OK
        //        return true
        // つづいて一般化 => OK
        // tips: enumはequatableに準拠するため、等価比較ができる
        return self.rank == card.rank
    }
    
    func isContinuousRank(_ card:Card)->Bool{
        return handleKingAndAce(self.rank.index - 1) == card.rank.index ||
            handleKingAndAce(self.rank.index + 1) == card.rank.index ||
            handleKingAndAce(card.rank.index + 1) == self.rank.index ||
            handleKingAndAce(card.rank.index + 1) == self.rank.index
    }
    
    func handleKingAndAce(_ index:Int)->Int{
        var handleIndex = 0
        
        if index > 12{
            handleIndex = 0
        } else if index < 0 {
            handleIndex = 12
        } else  {
            handleIndex = index
        }
        
        return handleIndex
    }
}
