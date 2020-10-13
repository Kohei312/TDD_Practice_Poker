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
    
    // カードにsuit・rankとも同じカードがないように初期化したい
    // TODO:
    //  - まず初期化時は、分配する10枚のCardインスタンスをランダムに作成する(引数はPlayerTypeのみ)
    //  - PlayerごとのHandインスタンスに[Card]を入れる
    var cardDeck = CardDeck()
    
    var myPlayerHand:Hand
    var otherPlayerHand:Hand
    
    init(){
        self.myPlayerHand = Hand(.me,cards:Array(cardDeck.unAppearCards[5..<10]))
        self.otherPlayerHand = Hand(.other,cards:Array(cardDeck.unAppearCards[0..<5]))
        cardDeck.throwAwayCard(10)
    }
    
    
    mutating func drawCard(playerType:PlayerType,takeNumber:Int,willRemoveIndex:IndexPath){
        //        let changeCards = cardDeck.changeCards(takeNumber)
        var removeCount = 0
        cardDeck.throwAwayCard(takeNumber)
        //        for card in changeCards{
        switch playerType{
        case .me:
            myPlayerHand.cards.remove(at: willRemoveIndex.row)
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
    
    mutating func addCard(playerType:PlayerType,takeNumber:Int,willRemoveIndex:IndexPath){
        let changeCards = cardDeck.changeCards(takeNumber)

        cardDeck.throwAwayCard(takeNumber)
        for i in 0..<takeNumber {
        switch playerType{
        case .me:
            myPlayerHand.cards.insert(changeCards[i], at: myPlayerHand.cards.count)
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
    mutating func changeCardIndex(playerType:PlayerType,willMoveIndex:IndexPath,willReplaceIndex:IndexPath){
        
        let changeCard = myPlayerHand.cards[willMoveIndex.row]
        
        
        switch playerType{
        case .me:
            myPlayerHand.cards.remove(at: willMoveIndex.row)
            myPlayerHand.cards.insert(changeCard, at: willReplaceIndex.row)
        case .other:
            otherPlayerHand.cards.remove(at: willMoveIndex.row)
            otherPlayerHand.cards.insert(changeCard, at: willReplaceIndex.row)
        }
    }
}


