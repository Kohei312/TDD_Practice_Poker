//
//  CardStub.swift
//  TDD_Practice_Poker
//
//  Created by kohei yoshida on 2020/10/07.
//

import Foundation

struct CardStub{
    var card_1:Card
    var card_2:Card
    var card_3:Card
    var card_4:Card
    var card_5:Card
    var card_6:Card
    
    var cards:[Card]
    var otherCards:[Card]
    
    init(){
        card_1 = Card(suit: .diamond, rank: .two)
        card_2 = Card(suit: .heart, rank: .three)
        card_3 = Card(suit: .club, rank: .jack)
        card_4 = Card(suit: .spade, rank: .queen)
        card_5 = Card(suit: .diamond, rank: .king)
        
        card_6 = Card(suit: .diamond, rank: .ace)
        cards = [card_1,card_2,card_3,card_4,card_5]
        otherCards = [card_1,card_6,card_3,card_4,card_5]
    }
    
}
