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
    
    func testHasSameSuit(){
        
        // 一般化が確認できたら、リファクタリング
        var card_1 :Card
        var card_2 :Card
        
        // 仮実装での挙動確認 OK
        card_1 = Card(suit: .club, rank: .ace)
        card_2 = Card(suit: .diamond, rank: .jack)
        XCTAssertTrue(card_1.hasSameSuit(card_2))
        
        // 一般化をすすめる => OK
        card_1 = Card(suit: .diamond, rank: .ace)
        card_2 = Card(suit: .diamond, rank: .jack)
        XCTAssertTrue(card_1.hasSameSuit(card_2))
    }
    
    
    
}
