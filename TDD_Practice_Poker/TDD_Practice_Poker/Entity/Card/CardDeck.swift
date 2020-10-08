//
//  CardDeck.swift
//  TDD_Practice_Poker
//
//  Created by kohei yoshida on 2020/10/08.
//

import Foundation

// MARK:- 他でプロパティをいじられたくない.
// CardDeckは唯一のインスタンスをHandStateに
struct CardDeck{
    
    private var unAppearCards:[Card]
    private var appearedCards:[Card] = []
    init(){
        unAppearCards = CardDeck.makeCardDeck()
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
        return cards.shuffled()
    }
    
    mutating func getCards(_ takeNumber:Int)->[Card]{
        
        let cards = Array(unAppearCards[0...takeNumber])
        throwAwayCard(takeNumber)
        return cards
    }
    
    mutating func takeCardFromUnAppearCards(_ takeNumber:Int){
        for i in 0...takeNumber{
            appearedCards.append(self.unAppearCards[i])
            self.unAppearCards.remove(at: i)
        }
    }
    
    mutating func throwAwayCard(_ takeNumber:Int){
        for i in 0...takeNumber{
            appearedCards.append(self.unAppearCards[i])
            self.unAppearCards.remove(at: i)
        }
    }
}
