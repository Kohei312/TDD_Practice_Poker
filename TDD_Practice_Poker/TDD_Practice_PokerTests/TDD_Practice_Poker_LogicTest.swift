//
//  TDD_Practice_Poker_LogicTest.swift
//  TDD_Practice_PokerTests
//
//  Created by kohei yoshida on 2020/10/04.
//

import XCTest
@testable import TDD_Practice_Poker

class TDD_Practice_Poker_LogicTest: XCTestCase {
    
    //              MARK:- 動作確認済み
    //    func testInitializePlayer(){
    //        var card_1:Card
    //        var card_2:Card
    //
    //        var hand_1:Hand
    //        var handStatus:HandStatus
    //
    //        card_1 = Card(suit: .club, rank: .three)
    //        card_2 = Card(suit: .diamond, rank: .king)
    //        hand_1 = Hand(cards:[card_1,card_2])
    //        handStatus = HandStatus(hand:hand_1)
    //
    //        let player_1 = Player(playerType:.me,handStatus:handStatus)
    //        XCTAssertEqual(player_1.playerType, PlayerType.me)
    //    }
    
    //              MARK:- 動作確認済み
    //    func testComparePlayerHands(){
    //        var card_1:Card
    //        var card_2:Card
    //
    //        var hand_1:Hand
    //        var handStatus:HandStatus
    //
    //        card_1 = Card(suit: .club, rank: .three)
    //        card_2 = Card(suit: .diamond, rank: .king)
    //        hand_1 = Hand(cards:[card_1,card_2])
    //        handStatus = HandStatus(hand:hand_1)
    //
    //        let player_1 = Player(playerType:.me,handStatus:handStatus)
    //        XCTAssertEqual(player_1.handStatus.handState, HandState.highCard)
    //
    //        card_1 = Card(suit: .club, rank: .king)
    //        card_2 = Card(suit: .diamond, rank: .king)
    //        hand_1 = Hand(cards:[card_1,card_2])
    //        handStatus = HandStatus(hand:hand_1)
    //
    //        let player_2 = Player(playerType:.other,handStatus:handStatus)
    //        XCTAssertEqual(player_2.handStatus.handState, HandState.pair)
    //        XCTAssertTrue(player_1.handStatus.handState < player_2.handStatus.handState)
    //    }
    
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
////        XCTAssertTrue(player_1.handStatus.handState < player_2.handStatus.handState)
//        
//        // テストOK...だけど、基底クラスのCardのComparable定義が逆だったために起こるエラーがここで判明...怖い
//        let playerStatus = PlayerStatus(players:[player_1,player_2])
//        XCTAssertEqual(playerStatus.PlayerState,PlayerState.lose)
//
//    }
}
