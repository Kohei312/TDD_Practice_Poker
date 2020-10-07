//
//  Hand.swift
//  TDD_Practice_Poker
//
//  Created by kohei yoshida on 2020/10/03.
//

import Foundation
// Playerと状態を共有するため、ここはclass化
class Hand:HandProtocol,HandStatusProtocol{
    
    #warning("ただし、手札が0,または1枚のときに必ずクラッシュする")
    var cards:[Card]
    // スタブ 用
    init(_ cards:[Card]){
        self.cards = cards
    }
// カードにsuit・rankとも同じカードがないように初期化したい
//    init(){
//        cards = (1..<5).enumerated().map {_ in
//            drawCard()
//        }
//    }
    
    var hasAllEqualSuit:[ Card.Suit ]{
        checkAllEqualSuit()
    }
    var hasEqualRank:[ Card.Rank:HandState ]{
        checkEqualRanks()
    }
    var hasContinuousRank:[ Card.Rank ]{
        checkContinuiousRank()
    }
    
    var handState:HandState{
        manageHandState()
    }
    
    // カードプロパティは、ここで取得する
    func getCards()->[Card]{
        return cards
    }
    
    func drawCard()->Card{
        let suit = Card.Suit.allCases.randomElement()!
        let rank = Card.Rank.allCases.randomElement()!
        
        return Card(suit: suit, rank: rank)
    }
    
    // ハッシュ値をつかって更新する
    func changeCard(_ willChangeCard:Card){
        guard let i = self.cards.firstIndex(of: willChangeCard) else {return}
        
        cards[i] = drawCard()
    }
    
}
