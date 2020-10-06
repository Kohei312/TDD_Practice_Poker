//
//  Card.swift
//  TDD_Practice_Poker
//
//  Created by kohei yoshida on 2020/10/03.
//

import Foundation

enum CardType{
    case Suit
    case Rank
}

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
    
    func hasSameRank(_ card:Card)->[Card]{
        // まずは期待値をベタ書きする仮実装 => OK
        //        return true
        // つづいて一般化 => OK
        // tips: enumはequatableに準拠するため、等価比較ができる
        var sameRankCards:[Card] = []
        
        
        if self.rank == card.rank{
            sameRankCards = [self,card]
        }
        
        
        // 仮実装OK
        return sameRankCards
    }
    
    func isContinuousRank(_ nextCard:Card)->Bool{
        // z番目とz+1番目が連続しているのか知りたい
        // AceはKing,twoとせっすることを保証
        var isContinue = false
        
        if (self.rank.index+1) == nextCard.rank.index{
            isContinue = true
        } else if self.rank == .two && nextCard.rank == .jack{
            isContinue = true
        } else if self.rank == .three && nextCard.rank == .queen{
            isContinue = true
        } else if self.rank == .four && nextCard.rank == .king{
            isContinue = true
        } else if self.rank == .five && nextCard.rank == .ace{
            isContinue = true
        }
        
        return isContinue
    }
}
