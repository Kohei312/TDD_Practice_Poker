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
        self.myPlayerHand = Hand(.me,cards:Array(cardDeck.unAppearCards[0..<5]))
        self.otherPlayerHand = Hand(.other,cards:Array(cardDeck.unAppearCards[6..<10]))
        cardDeck.throwAwayCard(10)
    }
    
    
//    #warning("Cardインスタンスの消去方法は検討.")
//    mutating func drawCard(playerType:PlayerType,takeNumber:Int,removeCardIndex:[Int]){
    mutating func drawCard(playerType:PlayerType,takeNumber:Int,willRemoveIndex:IndexPath){
        let changeCards = cardDeck.changeCards(takeNumber)
        var removeCount = 0
        
        for card in changeCards{
            switch playerType{
            case .me:
                // outof Range
                myPlayerHand.cards.remove(at: willRemoveIndex.row)
                // 一番最後に挿入する
                myPlayerHand.cards.insert(card, at: myPlayerHand.cards.count)
//                myPlayerHand.cards[ removeCardIndex[removeCount] ] = card
            case .other:
                otherPlayerHand.cards.remove(at: willRemoveIndex.row)
                // 一番最後に挿入する
                otherPlayerHand.cards.insert(card, at: otherPlayerHand.cards.count)
//                otherPlayerHand.cards[ removeCardIndex[removeCount] ] = card
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
                // outof Range
//                myPlayerHand.cards[ willReplaceIndex.row ] = changeCard
                myPlayerHand.cards.remove(at: willMoveIndex.row)
                myPlayerHand.cards.insert(changeCard, at: willReplaceIndex.row)
            case .other:
                otherPlayerHand.cards.remove(at: willMoveIndex.row)
                otherPlayerHand.cards.insert(changeCard, at: willReplaceIndex.row)
            }
    }
}


