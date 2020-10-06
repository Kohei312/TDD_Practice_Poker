//
//  TDD_Practice_Poker_FiveCardLogicTests.swift
//  TDD_Practice_PokerTests
//
//  Created by kohei yoshida on 2020/10/05.
//

import XCTest
@testable import TDD_Practice_Poker

class TDD_Practice_Poker_FiveCardLogicTests: XCTestCase {
    
    //                  MARK:- 動作確認済み
    //        func testComparePlayerHands(){
    //            var card_1:Card
    //            var card_2:Card
    //            var card_3:Card
    //            var card_4:Card
    //            var card_5:Card
    //
    //            var hand_1:Hand
    //            var handStatus_1:HandStatus
    //
    //            var hand_2:Hand
    //            var handStatus_2:HandStatus
    //
    //            // 3: まけ
    //            card_1 = Card(suit: .heart, rank: .jack)
    //            card_2 = Card(suit: .club, rank: .ace)
    //            card_3 = Card(suit: .spade, rank: .two)
    //            card_4 = Card(suit: .diamond, rank: .king)
    //            card_5 = Card(suit: .heart, rank: .queen)
    //            hand_1 = Hand(cards:[card_1,card_2,card_3,card_4,card_5])
    //            handStatus_1 = HandStatus(hand:hand_1)
    //
    //            let player_me = Player(playerType:.me,handStatus:handStatus_1)
    //            XCTAssertEqual(player_me.handStatus.handState, HandState.flush)
    //
    //            // K
    //            card_1 = Card(suit: .heart, rank: .jack)
    //            card_2 = Card(suit: .club, rank: .three)
    //            card_3 = Card(suit: .spade, rank: .three)
    //            card_4 = Card(suit: .diamond, rank: .king)
    //            card_5 = Card(suit: .heart, rank: .queen)
    //            hand_2 = Hand(cards:[card_1,card_2,card_3,card_4,card_5])
    //            handStatus_2 = HandStatus(hand:hand_2)
    //
    //            let player_2 = Player(playerType:.other,handStatus:handStatus_2)
    //            XCTAssertEqual(player_2.handStatus.handState, HandState.flush)
    //
    //            let playerStatus = PlayerStatus(players:[player_me,player_2])
    //            XCTAssertEqual(playerStatus.PlayerState,PlayerState.lose)
    //        }
    
    
    func testCompareSamePlayerHands(){
        var card_1:Card
        var card_2:Card
        var card_3:Card
        var card_4:Card
        var card_5:Card
        
        var hand_1:Hand
        var handStatus_1:HandStatus
        
        var hand_2:Hand
        var handStatus_2:HandStatus
        
        // わんペア　8
        card_1 = Card(suit: .diamond, rank: .queen)
        card_2 = Card(suit: .heart, rank: .queen)
        card_3 = Card(suit: .club, rank: .king)
        card_4 = Card(suit: .spade, rank: .king)
        card_5 = Card(suit: .diamond, rank: .queen)
        hand_1 = Hand(cards:[card_1,card_2,card_3,card_4,card_5])
        handStatus_1 = HandStatus(hand:hand_1)
//        XCTAssertTrue(handStatus_1.hand.hasEqualSuit == [] , "中身は : \(handStatus_1.hand.hasEqualSuit)")
        
        let player_me = Player(playerType:.me,handStatus:handStatus_1)
        XCTAssertEqual(player_me.handStatus.handState, HandState.flush)
        
        // わんペア 8
        card_1 = Card(suit: .club, rank: .queen)
        card_2 = Card(suit: .heart, rank: .king)
        card_3 = Card(suit: .diamond, rank: .king)
        card_4 = Card(suit: .spade, rank: .queen)
        card_5 = Card(suit: .club, rank: .queen)
        hand_2 = Hand(cards:[card_1,card_2,card_3,card_4,card_5])
        handStatus_2 = HandStatus(hand:hand_2)
        
        let player_2 = Player(playerType:.other,handStatus:handStatus_2)
        XCTAssertEqual(player_2.handStatus.handState, HandState.flush)
        XCTAssertTrue(player_me.handStatus.handState == player_2.handStatus.handState)
        
        let playerStatus = PlayerStatus(myPlayer: player_me, otherPlayers: [player_2])
        XCTAssertEqual(playerStatus.PlayerState,PlayerState.draw)
        
    }
    
}
