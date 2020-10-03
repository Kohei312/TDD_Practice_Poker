//
//  TDD_Practice_PokerTests.swift
//  TDD_Practice_PokerTests
//
//  Created by kohei yoshida on 2020/10/03.
//

import XCTest
@testable import TDD_Practice_Poker


// TODO:- Cardを定義する
// 1. Rankをenumで作成(不変の定義のため)
// 2. Suitをenumで作成(不変の定義のため)
class TDD_Practice_PokerTests: XCTestCase {
    
    //  MARK:- 動作確認済み
    //    func testInitializeCard(){
    //        var card:Card
    //
    //        card = Card(suit: .club, rank: .ace)
    //        XCTAssertEqual(card.suit, .heart)
    //        XCTAssertEqual(card.rank, .three)
    
    //        card = Card(suit: .spade, rank: .jack)
    //        XCTAssertEqual(card.suit, .heart)
    //        XCTAssertEqual(card.rank, .three)
    
    //    }
    
    
    //  MARK:- 動作確認済み
    //    func testNotifyCard(){
    //
    //        var card:Card
    //
    //        card = Card(suit: .diamond, rank: .eight)
    //        XCTAssertEqual(card.notify, "♦︎8")
    //
    //        card = Card(suit: .spade, rank: .three)
    //        XCTAssertEqual(card.notify, "♠︎3")
    //    }
    
    
    //  MARK:- 動作確認済み
    //    func testHasSameSuit(){
    //
    //        // 一般化が確認できたら、リファクタリング
    //        var card_1 :Card
    //        var card_2 :Card
    //
    //        // 仮実装での挙動確認 OK
    //        card_1 = Card(suit: .club, rank: .ace)
    //        card_2 = Card(suit: .diamond, rank: .jack)
    //        XCTAssertTrue(card_1.hasSameSuit(card_2))
    //
    //        // 一般化をすすめる => OK
    //        card_1 = Card(suit: .diamond, rank: .ace)
    //        card_2 = Card(suit: .diamond, rank: .jack)
    //        XCTAssertTrue(card_1.hasSameSuit(card_2))
    //    }
    
    
    
    //  MARK:- 動作確認済み
    //    func testHasSameRank(){
    
    //        // 最後にリファクタリング
    //        var card_1:Card
    //        var card_2:Card
    //
    //        // 仮実装での挙動確認 OK
    //        card_1 = Card(suit: .club, rank: .jack)
    //        card_2 = Card(suit: .diamond, rank: .jack)
    //        XCTAssertTrue(card_1.hasSameRank(card_2))
    //
    //        // つづいて一般化 => OK
    //        card_1 = Card(suit: .club, rank: .jack)
    //        card_2 = Card(suit: .diamond, rank: .jack)
    //        XCTAssertTrue(card_1.hasSameRank(card_2))
    //
    //    }
    
    //  MARK:- 動作確認済み
    //    func testCardEqual(){
    //        // tips: XCTAsserEqualの引数内で初期化処理を書いてスッキリ
    //        // Suit, Rankとも同じ場合を検証 => OK
    //        XCTAssertEqual(
    //            Card(suit: .diamond, rank: .jack),
    //            Card(suit: .diamond, rank: .jack)
    //        )
    //
    //
    //        // Suit, Rankとも同じでないケースを検証 => OK
    //        XCTAssertNotEqual(
    //            Card(suit: .spade, rank: .five),
    //            Card(suit: .spade, rank: .four)
    //        )
    //
    //        // Suitは同じ, Rankが異なる場合を検証 => OK
    //        XCTAssertNotEqual(
    //            Card(suit: .spade, rank: .five),
    //            Card(suit: .spade, rank: .four)
    //        )
    //
    //        // Suitは異なり, Rankが同じ場合を検証 => OK
    //        XCTAssertNotEqual(
    //            Card(suit: .spade, rank: .five),
    //            Card(suit: .club, rank: .five)
    //        )
    //
    //    }
    
    //  MARK:- 動作確認済み
    //    func testIsPair(){
    //
    //        var card_1:Card
    //        var card_2:Card
    //        var hand:Hand
    //
    //        card_1 = Card(suit: .diamond, rank: .jack)
    //        card_2 = Card(suit: .diamond, rank: .jack)
    //        hand = Hand(cards:[card_1,card_2])
    //        // まずは仮実装 => OK
    //        XCTAssertEqual(hand.isPair, true)
    //
    //        // 一般化 => OK
    //        card_1 = Card(suit: .diamond, rank: .ace)
    //        card_2 = Card(suit: .diamond, rank: .jack)
    //        hand = Hand(cards:[card_1,card_2])
    //
    //        XCTAssertEqual(hand.isPair, true)
    //
    //
    //    }
    
    
    //  MARK:- 動作確認済み
    //    func testIsFlush(){
    //
    //        var card_1:Card
    //        var card_2:Card
    //        var hand:Hand
    //
    //        card_1 = Card(suit: .diamond, rank: .jack)
    //        card_2 = Card(suit: .diamond, rank: .jack)
    //        hand = Hand(cards:[card_1,card_2])
    //        // まずは仮実装 => OK
    //        XCTAssertEqual(hand.isFlush, true)
    //
    //        // 一般化 => OK
    //        card_1 = Card(suit: .spade, rank: .jack)
    //        card_2 = Card(suit: .diamond, rank: .jack)
    //        hand = Hand(cards:[card_1,card_2])
    //
    //        XCTAssertEqual(hand.isFlush, true)
    //
    //        card_1 = Card(suit: .diamond, rank: .ace)
    //        card_2 = Card(suit: .diamond, rank: .jack)
    //        hand = Hand(cards:[card_1,card_2])
    //
    //        XCTAssertEqual(hand.isFlush, true)
    //
    //
    //    }
    //
    
    
    //  MARK:- 動作確認済み
    //    func testIsHighCard(){
    //
    //        var card_1:Card
    //        var card_2:Card
    //        var hand:Hand
    //
    //        card_1 = Card(suit: .spade, rank: .ace)
    //        card_2 = Card(suit: .diamond, rank: .jack)
    //        hand = Hand(cards:[card_1,card_2])
    //        // まずは仮実装 => OK
    //        XCTAssertEqual(hand.isHighCard, true)
    //
    //        // 一般化 => OK
    //        card_1 = Card(suit: .spade, rank: .jack)
    //        card_2 = Card(suit: .diamond, rank: .jack)
    //        hand = Hand(cards:[card_1,card_2])
    //
    //        XCTAssertEqual(hand.isHighCard, true)
    //
    //        card_1 = Card(suit: .diamond, rank: .ace)
    //        card_2 = Card(suit: .diamond, rank: .jack)
    //        hand = Hand(cards:[card_1,card_2])
    //
    //        XCTAssertEqual(hand.isHighCard, true)
    //
    //
    //    }
    
    
    func testIsHand(){

        var card_1:Card
        var card_2:Card
        var hand:Hand
        var handState:HandState
        
        card_1 = Card(suit: .spade, rank: .ace)
        card_2 = Card(suit: .diamond, rank: .jack)
        hand = Hand(cards:[card_1,card_2])
        handState = HandStatus().updateHandState(hand)
        
        
        // 仮実装OK
//        XCTAssertEqual(hand.isEqualSuit,true)
//        XCTAssertEqual(hand.isEqualRank, true)
        XCTAssertEqual(handState, HandState.pair)

    }

}
