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
    func testCompareHands(){
        var card_1:Card
        var card_2:Card

        var hand_1:Hand
        var handState_1:HandState

        var hand_2:Hand
        var handState_2:HandState


        card_1 = Card(suit: .club, rank: .three)
        card_2 = Card(suit: .diamond, rank: .king)
        hand_1 = Hand(cards:[card_1,card_2])
        handState_1 = HandStatus(hand:hand_1).handState

        card_1 = Card(suit: .diamond, rank: .ace)
        card_2 = Card(suit: .diamond, rank: .king)
        hand_2 = Hand(cards:[card_1,card_2])
        handState_2 = HandStatus(hand:hand_2).handState

        XCTAssertTrue(handState_1 > handState_2)

    }
    
}
