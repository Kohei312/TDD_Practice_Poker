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
    func testHasSameSuit(){
        
        // 一般化が確認できたら、リファクタリング
        var card_1 :Card
        var card_2 :Card
        var card_3 :Card
        var hand:Hand

        // 仮実装での挙動確認 OK
//        card_1 = Card(suit: .club, rank: .ace)
//        card_2 = Card(suit: .diamond, rank: .jack)
//        card_3 = Card(suit: .diamond, rank: .jack)
//        XCTAssertTrue(card_1.hasSameSuit([card_2,card_3]))
        
        // 一般化をすすめる => OK
        card_1 = Card(suit: .spade, rank: .ace)
        card_3 = Card(suit: .spade, rank: .jack)
        card_2 = Card(suit: .heart, rank: .queen)
        hand = Hand(cards:[card_1,card_2,card_3])
        XCTAssertEqual(hand.hasEqualSuit,[])
    }
}
