//
//  Judgement.swift
//  TDD_Practice_Poker
//
//  Created by kohei yoshida on 2020/10/07.
//

import Foundation

//#warning("以下のPlayerStateは、JugdeStateへ")
//enum PlayerState{
//    case inPlaying
//    case win
//    case draw
//    case lose
//}
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


enum JudgeState{
    case win
    case draw
    case lose
}

// ここはContainerでまとめて初期化する
struct Judgement{
    
    // [Player変数]が必要
    var players = PlayerList()
    
    // ここのロジックはJudgementクラスへ
    #warning("以下のロジックは、JugdeStateへ")
    var PlayerState:JudgeState = .draw{
        didSet{
            dependency?.notifyResult()
        }
    }
    
     var dependency:JudgementStatusProtocol?

     init(dependency:JudgementStatusProtocol){
        self.dependency = dependency
     }
    
    
    
//    func hoge(){
//        
//        if let myHandStatus = players.filter({$0.playerType == .me}).last?.hand{
//            
//        }
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
}
