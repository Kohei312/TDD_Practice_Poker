//
//  CardDeck.swift
//  TDD_Practice_Poker
//
//  Created by kohei yoshida on 2020/10/08.
//

import Foundation

struct CardDeck{
    
    var cardDeck:[Card]
    init(){
        cardDeck = CardDeck.makeCardDeck()
    }
    
    static func makeCardDeck()->[Card]{
        
        var cards:[Card] = []
        
        for i in 0...3{
            let suit = Card.Suit.allCases[i]
            for k in 0...12{
                let rank = Card.Rank.allCases[k]
                cards.append(Card(suit: suit, rank: rank))
            }
        }
        return cards
    }
    
//    func drawCard(_ takeNumber:Int)->[Card]{
//    
//    }
}
