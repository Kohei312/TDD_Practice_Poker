//
//  Hand.swift
//  TDD_Practice_Poker
//
//  Created by kohei yoshida on 2020/10/03.
//

import Foundation
// MARK:- 手札の役の状態を監視する
enum HandState:Comparable{
    case nothing
    case highCard
    case onePair
    case twoPair
    case threeCard
    case straight
    case flush
    case fullHouse
    case fourCard
    case straightFlush
    case royalFlush
}

struct Hand:CardManagementProtocol,HandStatementProtocol{

    var playerType:PlayerType
    var cards:[Card]
    // MARK:- HandStatusで[Card]を作成して渡すこと
    init(_ playerType:PlayerType, cards:[Card]){
        self.playerType = playerType
        self.cards = cards
    }

    var handState:HandState{
        manageHandState()
    }
    
    var hasAllEqualSuit:[ Card.Suit ]{
        checkAllEqualSuit()
    }
    var hasEqualRank:[ Card.Rank:HandState ]{
        checkEqualRanks()
    }
    var hasContinuousRank:[ Card.Rank ]{
        checkContinuiousRank()
    }
    
    func checkThreeorFourEqualSuitIndex()->[Int]{

        var restCardIndex:[Int] = []

        let allSuits = Dictionary(grouping: cards.compactMap({$0.suit})){$0}
        if  allSuits.values.contains(where: {$0.count == 4}){
            for (index,card) in cards.enumerated() {
                if card.suit != allSuits.filter({$0.value.count == 4})[0].key{
                    restCardIndex.append(index)
                }
            }
        } else if  allSuits.values.contains(where: {$0.count == 3}){
            for (index,card) in cards.enumerated() {
                if card.suit != allSuits.filter({$0.value.count == 3})[0].key{
                    restCardIndex.append(index)
                }
            }
        }

        return restCardIndex
    }
}
