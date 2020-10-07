//
//  PlayerStatus.swift
//  TDD_Practice_Poker
//
//  Created by kohei yoshida on 2020/10/04.
//
//
//import Foundation
//
//
//#warning("以下のPlayerStateは、JugdeStateへ")
//enum PlayerState{
//    case inPlaying
//    case win
//    case draw
//    case lose
//}
//
//// Cardへ移動
////enum RankStrength:Comparable,CaseIterable{
////    case Strongest
////    case Stronger
////    case Middle
////    case Weaker
////    case Weakest
////}
//
//#warning("これはJudgementへ")
//protocol PlayerStatusProtocol{
//    
//    func compareCards(_ myHandStatus:Hand, otherHandStatus:Hand)->PlayerState
//    func compareCardRanks(myCardRank:Card.Rank,otherCardRank:Card.Rank)->PlayerState
//    
//    func makeLestCardRanks(_ handStatus:Hand,reduceRanks:[Card.Rank])->[Card.Rank]
//    func checkLestRank(_ lestRanks:[Card.Rank],returnStrength:RankStrength)->Card.Rank
//    
//    func checkTwoPairRank(_ handStatus:Hand,returnStrength:RankStrength)->Card.Rank
//    func checkStraightStrongRank(_ handStatus:Hand)->Card.Rank
//    func checkFullHousePairs(_ handStatus:Hand,returnPairType:HandState)->Card.Rank
//}
//
////enum ReadyButtleState{
////    case none
////    case readyButtle
////}
//
//// 仮実装OK
//// MARK:- プレーヤーが対決準備ができたか否かを監視する
//struct PlayerStatus:PlayerStatusProtocol{
//    
//    /*
//     var player: Player
//     // ToolBarの「勝負する」ボタンを押す, または
//     // 3回交換したら (交換カウントが0になったら) 変更される
//     // ↑を管理するクラスのProtocolをそれぞれココにDIし、UI更新を図る
//     var readyButtleState:ReadyButtleState = .none
//     
//     func isReadyButtle(){
//        if tapped ButtleBtn == true ||
//        changeNumberOfCard == 0{
//        readyButtleState = .readyButtle
//        GameFieldStatusProtocol?.changeGameFieldStatus()
//
//     }
//     
//    */
//    
//    
//    
//    var myPlayer:Player
//    var otherPlayers:[Player]
//    
//    // ここのロジックはJudgementクラスへ
//    #warning("以下のロジックは、JugdeStateへ")
//    var PlayerState:PlayerState{
//        
//        let myHandStatus = myPlayer.hand
//        
//        var playerState:PlayerState = .draw
//        for otherPlayer in otherPlayers{
//            
//            let otherHandStatus = otherPlayer.hand
//            
//            if myHandStatus.handState < otherHandStatus.handState{
//                
//                playerState = .lose
//                
//            } else if myHandStatus.handState > otherHandStatus.handState{
//               
//                playerState = .win
//                
//            } else if myHandStatus.handState == otherHandStatus.handState{
//                
//                playerState = self.compareCards(myHandStatus,otherHandStatus:otherHandStatus)
//            }
//        }
//        
//        return playerState
//    }
//}
