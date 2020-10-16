//
//  HandStatus.swift
//  TDD_Practice_Poker
//
//  Created by kohei yoshida on 2020/10/03.
//

import Foundation

protocol CPUBrainManagementProtocol{
    mutating func checkCPUCard()
    mutating func changeCardForCPU(playerType:PlayerType,willRemoveIndex:[Int])
}
// MARK:- PokerInteractorへOutputするProtocolをDIする
// MARK:- 役割は、各プレイヤーの手札を一元管理すること
struct HandStatus:RandomNumberProtocol,CPUBrainManagementProtocol{
    
    var cardDeck = CardDeck()
    var myPlayerHand:Hand
    var otherPlayerHand:Hand
    var interactorInputProtocol:InteractorInputProtocol?
    
    init(){
        self.myPlayerHand = Hand(.me,cards:Array(cardDeck.unAppearCards[5..<10]))
        self.otherPlayerHand = Hand(.other,cards:Array(cardDeck.unAppearCards[0..<5]))
        cardDeck.throwAwayCard(10)
        print(otherPlayerHand.cards)
        print(otherPlayerHand.handState)
    }
    
    
    mutating func changeCard(playerType:PlayerType,takeNumber:Int,willRemoveIndex:Int){
        let changeCards = cardDeck.takeCards(takeNumber)
//        var removeCount = 0
        cardDeck.throwAwayCard(takeNumber)
        for card in changeCards{
            switch playerType{
            case .me:
                myPlayerHand.cards.remove(at: willRemoveIndex)
                myPlayerHand.cards.insert(card, at: myPlayerHand.cards.count)
//                removeCount += 1
//                if takeNumber == removeCount{
//                    removeCount = 0
//
//                }
            case .other:
                break
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

extension HandStatus{
    mutating func changeCardForCPU(playerType:PlayerType,willRemoveIndex:[Int]){
        
        let changeCards = cardDeck.takeCards(willRemoveIndex.count)
        var removeCount = 0
        
        for (index,card) in changeCards.enumerated(){
            
            otherPlayerHand.cards.remove(at: willRemoveIndex[index])
            otherPlayerHand.cards.insert(card, at: otherPlayerHand.cards.count)
            
            removeCount += 1
            if changeCards.count == removeCount{
                removeCount = 0
                interactorInputProtocol?.completeCPUTurn()
            }
        }
    }
    // ここでCPUのロジックを決める
    mutating func checkCPUCard(){
        
        let currentState = otherPlayerHand.handState
        
        if currentState < .flush {
            // カードを交換する
            /* TODO:-
               交換するカードを抽出する -> ペア以外のカードが対象
               交換するカードの枚数を決める
               枚数が決まったら、カードのインデックスを取得する（インデックスは、カード全体から取得する）
            */
            let notEqualSuitCardIndex = otherPlayerHand.checkThreeorFourEqualSuitIndex()
            
            if currentState == .straight {
                // これで勝負
                
            } else if currentState < .straight && notEqualSuitCardIndex != [] {
                // フラッシュの可能性があるとき
                changeCardForCPU(playerType:.other,willRemoveIndex:notEqualSuitCardIndex)
            } else if currentState < .straight && notEqualSuitCardIndex == []{
                // フラッシュの可能性は低い場合
                if otherPlayerHand.hasEqualRank != [:]{
                    // ペアをうまく組み合わせる
                    calculateWhichCardWillThrowout(cardRank:otherPlayerHand.hasEqualRank.keys.map({$0}))
                } else if otherPlayerHand.hasContinuousRank.count >= 3{
                    //　ストレートを狙う
                    calculateWhichCardWillThrowout(cardRank:otherPlayerHand.hasContinuousRank)
                } else {
                    // ハイカード以下 -> とにかくやってみる
                    choiceRandomCardIndex()
                }
            } else {
                // ハイカード以下 -> とにかくやってみる
                choiceRandomCardIndex()
            }
            
        } else {
            // バトルをコールする
            
        }
    }
    
    mutating func calculateWhichCardWillThrowout(cardRank:[Card.Rank]){
        let currentCards = otherPlayerHand.cards
        var removeIndex:[Int] = []
        for (index, card) in currentCards.enumerated() {
            if cardRank.contains(where: {$0 == card.rank}){
                removeIndex.append(index)
            }
        }
        changeCardForCPU(playerType: .other, willRemoveIndex: removeIndex)
    }
    
    mutating func choiceRandomCardIndex(){
        let takeNumber = randomNumber(0..<UInt32(otherPlayerHand.cards.count))
        var randomIndex:[Int] = []
        for i in 0...takeNumber{
            randomIndex.append(i)
        }
        changeCardForCPU(playerType:.other,willRemoveIndex:randomIndex)
    }
}
