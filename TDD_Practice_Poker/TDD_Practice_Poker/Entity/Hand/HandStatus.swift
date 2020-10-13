//
//  HandStatus.swift
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



// MARK:- PokerInteractorへOutputするProtocolをDIする
// MARK:- 役割は、各プレイヤーの手札を一元管理すること
struct HandStatus{
    
    var cardDeck = CardDeck()
    var myPlayerHand:Hand
    var otherPlayerHand:Hand
    var interactorInputProtocol:InteractorInputProtocol?
    
    init(){
        self.myPlayerHand = Hand(.me,cards:Array(cardDeck.unAppearCards[5..<10]))
        self.otherPlayerHand = Hand(.other,cards:Array(cardDeck.unAppearCards[0..<5]))
        cardDeck.throwAwayCard(10)
    }
    
    
    mutating func throwCard(playerType:PlayerType,takeNumber:Int,willRemoveIndex:Int){
        //        let changeCards = cardDeck.changeCards(takeNumber)
        var removeCount = 0
        cardDeck.throwAwayCard(takeNumber)
        //        for card in changeCards{
        switch playerType{
        case .me:
            myPlayerHand.cards.remove(at: willRemoveIndex)
        //                myPlayerHand.cards.insert(card, at: myPlayerHand.cards.count)
        case .other:
            break
        //                otherPlayerHand.cards.insert(card, at: otherPlayerHand.cards.count)
        }
        removeCount += 1
        if takeNumber == removeCount{
            removeCount = 0
        }
        //            if changeCards.count == removeCount{
        //                removeCount = 0
        //            }
        //        }
    }
    
    mutating func addCard(playerType:PlayerType,takeNumber:Int){
        let changeCards = cardDeck.changeCards(takeNumber)

        for i in 0..<takeNumber {
        switch playerType{
        case .me:
            myPlayerHand.cards.insert(changeCards[i], at: myPlayerHand.cards.count)
            interactorInputProtocol?.notifyUpdatePlayerUI()
        case .other:
            break
        }
        }
    }
    
    mutating func drawCardForCPU(playerType:PlayerType,takeNumber:Int,willRemoveIndex:IndexPath){
        
        let changeCards = cardDeck.changeCards(takeNumber)
        var removeCount = 0
        
        for card in changeCards{
            switch playerType{
            case .me:
                break
            case .other:
                otherPlayerHand.cards.remove(at: willRemoveIndex.row)
                otherPlayerHand.cards.insert(card, at: otherPlayerHand.cards.count)
            }
            removeCount += 1
            if changeCards.count == removeCount{
                removeCount = 0
            }
        }
    }
    
    // OK
    mutating func changeCardIndex(playerType:PlayerType,willMoveIndex:Int,willReplaceIndex:Int){
        
        let changeCard = myPlayerHand.cards[willMoveIndex]
        
        
        switch playerType{
        case .me:
            myPlayerHand.cards.remove(at: willMoveIndex)
            myPlayerHand.cards.insert(changeCard, at: willReplaceIndex)
        case .other:
            otherPlayerHand.cards.remove(at: willMoveIndex)
            otherPlayerHand.cards.insert(changeCard, at: willReplaceIndex)
        }
    }
}


