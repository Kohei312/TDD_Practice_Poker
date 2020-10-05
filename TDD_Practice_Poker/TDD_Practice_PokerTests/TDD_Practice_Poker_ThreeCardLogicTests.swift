//
//  TDD_Practice_Poker_ThreeCardLogicTests.swift
//  TDD_Practice_PokerTests
//
//  Created by kohei yoshida on 2020/10/04.
//

import XCTest
@testable import TDD_Practice_Poker

class TDD_Practice_Poker_ThreeCardLogicTests: XCTestCase {
    
    //  MARK:- 動作確認済み
//    func testHasSameSuit(){
//
//        // 一般化が確認できたら、リファクタリング
//        var card_1 :Card
//        var card_2 :Card
//        var card_3 :Card
//        var hand:Hand
//
//        // 仮実装での挙動確認 OK
////        card_1 = Card(suit: .club, rank: .ace)
////        card_2 = Card(suit: .diamond, rank: .jack)
////        card_3 = Card(suit: .diamond, rank: .jack)
////        XCTAssertTrue(card_1.hasSameSuit([card_2,card_3]))
//
//        // 一般化をすすめる => OK
//        card_1 = Card(suit: .spade, rank: .ace)
//        card_3 = Card(suit: .spade, rank: .jack)
//        card_2 = Card(suit: .spade, rank: .queen)
//        hand = Hand(cards:[card_1,card_2,card_3])
//        XCTAssertEqual(hand.hasEqualSuit,[])
//    }
    
// MARK:- 動作確認済み
//    func testHasSameRank(){
//
//        // 一般化が確認できたら、リファクタリング
//        var card_1 :Card
//        var card_2 :Card
//        var card_3 :Card
//        var hand:Hand
//
//        // 仮実装での挙動確認 OK
////        card_1 = Card(suit: .club, rank: .ace)
////        card_2 = Card(suit: .diamond, rank: .jack)
////        card_3 = Card(suit: .diamond, rank: .jack)
////        XCTAssertTrue(card_1.hasSameSuit([card_2,card_3]))
//
//        // 一般化をすすめる => OK
//        card_1 = Card(suit: .club, rank: .three)
//        card_3 = Card(suit: .club, rank: .ace)
//        card_2 = Card(suit: .heart, rank: .ace)
//        hand = Hand(cards:[card_1,card_2,card_3])
//        XCTAssertEqual(hand.hasEqualSuit,[])
//    }
    
//    func testHasContinuousRank(){
//
//        // 一般化が確認できたら、リファクタリング
//        var card_1 :Card
//        var card_2 :Card
//        var card_3 :Card
//        var hand:Hand
//
//        // 仮実装での挙動確認 OK
////        card_1 = Card(suit: .club, rank: .ace)
////        card_2 = Card(suit: .diamond, rank: .jack)
////        card_3 = Card(suit: .diamond, rank: .jack)
////        XCTAssertTrue(card_1.hasSameSuit([card_2,card_3]))
//
//        // 一般化をすすめる => OK
//        card_1 = Card(suit: .club, rank: .three)
//        card_3 = Card(suit: .club, rank: .ace)
//        card_2 = Card(suit: .heart, rank: .two)
//        hand = Hand(cards:[card_1,card_2,card_3])
//
//        XCTAssertEqual(hand.hasContinuousRank,[])
////        let continuousRank = hand.hasContinuousRank
////        XCTAssertEqual(continuousRank,[])
//    }
    
    //              MARK:- 動作確認済み
//        func testComparePlayerHands(){
//            var card_1:Card
//            var card_2:Card
//            var card_3:Card
//
//            var hand_1:Hand
//            var handStatus_1:HandStatus
//
//            var hand_2:Hand
//            var handStatus_2:HandStatus
//
//            // 3: まけ
//            card_1 = Card(suit: .heart, rank: .three)
//            card_2 = Card(suit: .club, rank: .three)
//            card_3 = Card(suit: .spade, rank: .ace)
//            hand_1 = Hand(cards:[card_1,card_2,card_3])
//            handStatus_1 = HandStatus(hand:hand_1)
//
//            let player_me = Player(playerType:.me,handStatus:handStatus_1)
//            XCTAssertEqual(player_me.handStatus.handState, HandState.flush)
//
//            // K
//            card_1 = Card(suit: .heart, rank: .jack)
//            card_2 = Card(suit: .club, rank: .three)
//            card_3 = Card(suit: .spade, rank: .three)
//            hand_2 = Hand(cards:[card_1,card_2,card_3])
//            handStatus_2 = HandStatus(hand:hand_2)
//
//            let player_2 = Player(playerType:.other,handStatus:handStatus_2)
//            XCTAssertEqual(player_2.handStatus.handState, HandState.flush)
//            XCTAssertTrue(player_me.handStatus.handState == player_2.handStatus.handState)
//
//            let playerStatus = PlayerStatus(players:[player_me,player_2])
//            XCTAssertEqual(playerStatus.PlayerState,PlayerState.lose)
//        }
    
//    func testCompareSamePlayerHands(){
//        var card_1:Card
//        var card_2:Card
//
//        var hand_1:Hand
//        var handStatus:HandStatus
//
//        card_1 = Card(suit: .diamond, rank: .two)
//        card_2 = Card(suit: .diamond, rank: .ace)
//        hand_1 = Hand(cards:[card_1,card_2])
//        handStatus = HandStatus(hand:hand_1)
//        let player_1 = Player(playerType:.me,handStatus:handStatus)
//        XCTAssertEqual(player_1.handStatus.handState, HandState.straightFlush)
//
//
//        card_1 = Card(suit: .diamond, rank: .queen)
//        card_2 = Card(suit: .diamond, rank: .king)
//        hand_1 = Hand(cards:[card_1,card_2])
//        handStatus = HandStatus(hand:hand_1)
//        let player_2 = Player(playerType:.other,handStatus:handStatus)
//        XCTAssertEqual(player_2.handStatus.handState, HandState.straightFlush)
//
//
//        let playerStatus = PlayerStatus(players:[player_1,player_2])
//        XCTAssertEqual(playerStatus.PlayerState,PlayerState.lose)
//
//    }
}
