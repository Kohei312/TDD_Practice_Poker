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
    
    
    //    func testCompareSamePlayerHands(){
    ////        var card_1:Card
    ////        var card_2:Card
    ////        var card_3:Card
    ////        var card_4:Card
    ////        var card_5:Card
    ////
    ////        var hand_1:Hand
    ////        var handStatus_1:HandStatus
    //
    ////        var hand_2:Hand
    ////        var handStatus_2:HandStatus
    //
    //        // わんペア　8
    ////        card_1 = Card(suit: .diamond, rank: .two)
    ////        card_2 = Card(suit: .heart, rank: .three)
    ////        card_3 = Card(suit: .club, rank: .king)
    ////        card_4 = Card(suit: .spade, rank: .king)
    ////        card_5 = Card(suit: .diamond, rank: .ace)
    ////        hand_1 = Hand()
    //
    ////        handStatus_1 = HandStatus(hand:hand_1)
    ////        XCTAssertTrue(handStatus_1.hand.hasEqualSuit == [] , "中身は : \(handStatus_1.hand.hasEqualSuit)")
    //
    ////        let player_me = Player(playerType:.me,handStatus:handStatus_1)
    ////        let player_me = Player(playerType:.me,hand:hand_1)
    //        XCTAssertEqual(player_me.hand.handState, HandState.flush)
    ////        let i = player_me.isReadyButtle()
    ////        XCTAssertEqual(player_me.readyButtle, ReadyButtleState.readyButtle)
    //
    //        // わんペア 8
    ////        card_1 = Card(suit: .club, rank: .two)
    ////        card_2 = Card(suit: .heart, rank: .three)
    ////        card_3 = Card(suit: .diamond, rank: .king)
    ////        card_4 = Card(suit: .spade, rank: .king)
    ////        card_5 = Card(suit: .club, rank: .queen)
    ////        hand_2 = Hand()
    ////        handStatus_2 = HandStatus(hand:hand_2)
    //
    ////        let player_2 = Player(playerType:.other,hand:hand_2)
    //        XCTAssertEqual(player_2.hand.handState, HandState.flush)
    //        XCTAssertTrue(player_me.hand.handState == player_2.hand.handState)
    //
    //        let playerStatus = PlayerStatus(myPlayer: player_me, otherPlayers: [player_2])
    //        XCTAssertEqual(playerStatus.PlayerState,PlayerState.draw)
    //
    //
    //        hand_1.changeCard(Card(suit: .diamond, rank: .ace))
    //        XCTAssertEqual(playerStatus.PlayerState,PlayerState.draw)
    //
    //    }
    //
    
    //    func testInitializePlayerList(){
    //
    //        let playerList = PlayerList()
    //        XCTAssertEqual(playerList.player_me.hand.handState, HandState.onePair)
    //
    //        XCTAssertEqual(playerList.player_other.hand.handState, HandState.onePair)
    //        XCTAssertTrue(playerList.player_me.hand.handState == playerList.player_other.hand.handState)
    //
    //        let playerStatus = Judgement()
    //        XCTAssertEqual(playerStatus.playerState,JudgeState.draw)
    //
    //
    //        playerList.player_me.hand.changeCard(Card(suit: .diamond, rank: .ace))
    //        XCTAssertEqual(playerStatus.playerState,JudgeState.draw)
    //
    //    }
    //
    
    //    func testJudgement(){
    //
    //        var judgement = JudgementStatus()
    //        let playerList = judgement.players
    //        XCTAssertEqual(playerList.player_me.hand.handState, HandState.onePair)
    //
    //        XCTAssertEqual(playerList.player_other.hand.handState, HandState.onePair)
    //        XCTAssertTrue(playerList.player_me.hand.handState == playerList.player_other.hand.handState)
    //
    //
    //        XCTAssertEqual(judgement.judge(),Judgement.draw)
    //
    //
    //        playerList.player_me.hand.changeCard(Card(suit: .diamond, rank: .ace))
    //        XCTAssertEqual(judgement.judge(),Judgement.lose)
    //
    //    }
    
    
    //    func testJudgement(){
    //
    //        var playerList = PlayerStatus()
    //
    //        XCTAssertTrue(playerList.player_me.readyButtle == playerList.player_other.readyButtle)
    //        playerList.isReadyButtle(.me)
    //        playerList.isReadyButtle(.other)
    //        XCTAssertTrue(playerList.player_me.readyButtle == playerList.player_other.readyButtle)
    ////        XCTAssertEqual(playerList.player_me.hand.handState, HandState.onePair)
    ////        XCTAssertEqual(playerList.player_other.hand.handState, HandState.onePair)
    ////        XCTAssertTrue(playerList.player_me.hand.handState == playerList.player_other.hand.handState)
    ////
    ////        XCTAssertEqual(judgement.judge(),Judgement.draw)
    ////
    ////
    ////        playerList.player_me.hand.changeCard(Card(suit: .diamond, rank: .ace))
    ////        XCTAssertEqual(judgement.judge(),Judgement.lose)
    //
    //    }
    func testhandStatus(){
        
        //        var playerList = HandStatus(myPlayerType: .me, otherPlayerType: .other)
        //
        //        XCTAssertEqual(playerList.myPlayerHand.cards, [Card(suit: .club, rank: .ace)])
        //        XCTAssertEqual(playerList.otherPlayerHand.cards,[Card(suit: .club, rank: .ace)])
        //        XCTAssertEqual(playerList.appearedCards,[Card(suit: .club, rank: .ace)])
        //        XCTAssertEqual(playerList.player_me.hand.handState, HandState.onePair)
        //        XCTAssertEqual(playerList.player_other.hand.handState, HandState.onePair)
        //        XCTAssertTrue(playerList.player_me.hand.handState == playerList.player_other.hand.handState)
        //
        //        XCTAssertEqual(judgement.judge(),Judgement.draw)
        //
        //
        //        playerList.player_me.hand.changeCard(Card(suit: .diamond, rank: .ace))
        //        XCTAssertEqual(judgement.judge(),Judgement.lose)
        
    }
    // MARK:- スタブでは動作確認ok
    //    func testCardDeck(){
    //
    //        var pokerInteractor = PokerInteractor()
    //        XCTAssertEqual(pokerInteractor.handStatus.myPlayerHand.cards, [])
    //        let i = pokerInteractor.drawCard(takeNumber:2,playerType:.me,removeCardIndex:[1,3])
    //        XCTAssertEqual(i, [])
    //        XCTAssertEqual(pokerInteractor.handStatus.myPlayerHand.cards, [])
    //
    //
    //    }
    
    
    func testPass(){
        
        var pokerInteractor = PokerInteractor()
        XCTAssertEqual(pokerInteractor.player_me.player.changeCount, 0)
        XCTAssertEqual(pokerInteractor.player_me.player.playerStatement, .isReadyButtle)
        XCTAssertEqual(pokerInteractor.gameFieldStatus.gameSide, .other)
        pokerInteractor.chosePass(.me)
        XCTAssertEqual(pokerInteractor.player_me.player.changeCount, 0)
        XCTAssertEqual(pokerInteractor.player_me.player.playerStatement, .isReadyButtle)
        XCTAssertEqual(pokerInteractor.gameFieldStatus.gameSide, .me)
        
//        XCTAssertEqual(pokerInteractor.handStatus.myPlayerHand.cards, [])
        
        
    }
    
    
}
