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
        self.myPlayerHand = Hand(.me,cards:Array(cardDeck.changeCards(5)))
        self.otherPlayerHand = Hand(.other,cards:Array(cardDeck.changeCards(5)))
    }
    
    
    #warning("Cardインスタンスの消去方法は検討.")
    mutating func drawCard(takeNumber:Int,playerType:PlayerType,removeCardIndex:[Int]){
        
        let changeCards = cardDeck.changeCards(takeNumber)
        var removeCount = 0
        
        for card in changeCards{
            switch playerType{
            case .me:
                myPlayerHand.cards[ removeCardIndex[removeCount] ] = card
            case .other:
                otherPlayerHand.cards[ removeCardIndex[removeCount] ] = card
            }
            removeCount += 1
            if changeCards.count == removeCount{
                removeCount = 0
            }
        }
        #warning("ここでprotocolを介してInteratorに状態変更を伝達、UI更新を促す")
    }
}


