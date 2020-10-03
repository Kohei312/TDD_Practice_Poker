//
//  Hand.swift
//  TDD_Practice_Poker
//
//  Created by kohei yoshida on 2020/10/03.
//

import Foundation

struct Hand{
    
    #warning("ただし、手札が0,または1枚のときに必ずクラッシュする")
    var cards:[Card]
    // ベタ書き仮実装 => OK
//    var isPair: Bool{
//        // TODO:- isPair を判定する条件 => Computed Property内でひとまずOK
//        return cards[0].rank == cards[1].rank
//    }
//
//    var isFlush: Bool{
//        return cards[0].suit == cards[1].suit
//    }
//
//    var isHighCard: Bool{
//        return (cards[0].suit != cards[1].suit) && (cards[0].rank != cards[1].rank)
//    }
    
    var isEqualSuit: Bool{
        return cards[0].suit == cards[1].suit
    }
    var isEqualRank: Bool{
        return cards[0].rank == cards[1].rank
    }
    
}
