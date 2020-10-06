//
//  PlayerStatus.swift
//  TDD_Practice_Poker
//
//  Created by kohei yoshida on 2020/10/04.
//

import Foundation

enum PlayerState{
    case inPlaying
    case win
    case draw
    case lose
}


// 仮実装OK
struct PlayerStatus{
    
    var players:[Player]
    var myPlayer:[Player]{
        players.filter({$0.playerType == PlayerType.me})
    }
    var otherPlayers:[Player]{
        players.filter({$0.playerType == PlayerType.other})
    }
    
    var PlayerState:PlayerState{
        
        var state:PlayerState = .draw
        
        for otherPlayer in otherPlayers{
            
            let myHandStatus = myPlayer[0].handStatus
            let otherHandStatus = otherPlayer.handStatus
            
            if myHandStatus.handState < otherHandStatus.handState{
                state = .lose
            } else if myHandStatus.handState > otherHandStatus.handState{
                print("かち")
                state = .win
            } else if myHandStatus.handState == otherHandStatus.handState{
                print("ひきわけ")
                state = self.compareCards(myHandStatus,otherHandStatus:otherHandStatus)
            }
        }
        
        return state
    }
    
    // 仮実装OK
    func compareCards(_ myHandStatus:HandStatus, otherHandStatus:HandStatus)->PlayerState{
        
        let handState = myHandStatus.handState
        let myCards = myHandStatus.hand.cards.compactMap({$0.rank}).sorted()
        let otherCards = otherHandStatus.hand.cards.compactMap({$0.rank}).sorted()
        
        var state:PlayerState = .inPlaying
        
        switch handState{
        case .nothing:
            break
        case .highCard,.flush:
            
            state = self.compareCardRanks(myCardRank: checkLestRank(myCards, returnStrength: .Strongest), otherCardRank: checkLestRank(otherCards, returnStrength: .Strongest))
            
            if state == .draw{
                
                state = self.compareCardRanks(myCardRank: checkLestRank(myCards, returnStrength: .Stronger), otherCardRank: checkLestRank(otherCards, returnStrength: .Stronger))
                
                if state == .draw{
                    state = self.compareCardRanks(myCardRank: checkLestRank(myCards, returnStrength: .Middle), otherCardRank: checkLestRank(otherCards, returnStrength: .Middle))
                    if state == .draw{
                        state = self.compareCardRanks(myCardRank: checkLestRank(myCards, returnStrength: .Weaker), otherCardRank: checkLestRank(otherCards, returnStrength: .Weaker))
                        if state == .draw{
                            state = self.compareCardRanks(myCardRank: checkLestRank(myCards, returnStrength: .Weakest), otherCardRank: checkLestRank(otherCards, returnStrength: .Weakest))
                            break
                        }
                    }
                }
            }
            break
        case .onePair:
            // MARK:- 1回目： 強いペアを比較
            guard let myPairCards = myHandStatus.hand.hasEqualRank.keys.max(),
                  let myStrongPairRank = Card.Rank(rawValue: myPairCards.rawValue) else{
                return .draw
            }
            guard let otherPairCards = otherHandStatus.hand.hasEqualRank.keys.max(),
                  let otherStrongPairRank = Card.Rank(rawValue: otherPairCards.rawValue) else{
                return .draw
            }
        
            state = self.compareCardRanks(myCardRank: myStrongPairRank, otherCardRank: otherStrongPairRank)
            
            if state == .draw{
                
                // MARK:- 以降： ペア以外を比較
                // MARK:- 2回目： 最強ランクを比較
                let myLestCards = myHandStatus.hand.cards.filter({$0.rank != myStrongPairRank}).compactMap({$0.rank})
                let otherLestCards = otherHandStatus.hand.cards.filter({$0.rank != otherStrongPairRank}).compactMap({$0.rank})
                
                state = self.compareCardRanks(myCardRank: checkLestRank(myLestCards, returnStrength: .Strongest), otherCardRank: checkLestRank(otherLestCards, returnStrength: .Strongest))
                
                if state == .draw{
                    // MARK:- 3回目： 中間のカードを比較
                    state = self.compareCardRanks(myCardRank: checkLestRank(myLestCards, returnStrength: .Middle), otherCardRank: checkLestRank(otherLestCards, returnStrength: .Middle))
                    
                    if state == .draw{
                        // MARK:- 3回目： 中間のカードを比較
                        state = self.compareCardRanks(myCardRank: checkLestRank(myLestCards, returnStrength: .Weakest), otherCardRank: checkLestRank(otherLestCards, returnStrength: .Weakest))
                        break
                    }
                }
                
            }
            
            break
        case .straight:
            
            var myRank:Card.Rank{
                checkStraightStrongRank(myHandStatus)
            }
            var otherRank:Card.Rank{
                checkStraightStrongRank(otherHandStatus)
            }
            
            state = self.compareCardRanks(myCardRank: myRank, otherCardRank: otherRank)
            break
            
        case.threeCard:
            
//            state = self.compareCardRanks(myCard: myStrongCard, otherCard: otherStrongCard)
//            if state == .draw{
//                state = self.compareCardRanks(myCard: myWeakCard, otherCard: otherWeakCard)
//            }
            break
            
        case .straightFlush:
            
            var myRank:Card.Rank{
                checkStraightStrongRank(myHandStatus)
            }
            var otherRank:Card.Rank{
                checkStraightStrongRank(otherHandStatus)
            }
            
            
            state = self.compareCardRanks(myCardRank: myRank, otherCardRank: otherRank)
            break
        case .twoPair:
            break
        case .fullHouse:
            break
        case .fourCard:
            break
        case .royalFlush:
            state = .draw
        }
        
        return state
    }
    
    func compareCardRanks(myCardRank:Card.Rank?,otherCardRank:Card.Rank?)->PlayerState{
        
        var currentState:PlayerState = .draw
        
        guard let myRank = myCardRank else {
            currentState = .lose
            return currentState
        }
        
        guard let otherRank = otherCardRank else {
            currentState = .win
            return currentState
        }
        
        print("カード比較 :")
        print("myRank :", myRank)
        print("otherRank :", otherRank)
        
        if myRank < otherRank{
            currentState = .lose
        } else if myRank > otherRank{
            currentState = .win
        } else if myRank == otherRank{
            currentState = .draw
        }
        
        return currentState
    }
}

extension PlayerStatus{
    
//    func checkPairRank(_ pairCards:[[Card]],returnStrength:RankStrength)->Card.Rank{
//        
//        var rank:Card.Rank = .two
//        
//        switch returnStrength{
//        case .Strongest:
//            break
//        case .Stronger:
//            guard let strongRank = pairCards.compactMap({$0.max{a,b in a.rank < b.rank}}).last?.rank else{return rank}
//            rank = strongRank
//        case .Middle:
//            break
//        case .Weaker:
//            guard let weakRank = pairCards.compactMap({$0.min{a,b in a.rank < b.rank}}).last?.rank else{return rank}
//            rank = weakRank
//        case .Weakest:
//            break
//        }
//        return rank
//    }
    
    // ハイカード・ワンペア・フラッシュで使用
    // 引数のlestRankには、Pairを取り除いた配列を入れる
    func checkLestRank(_ lestRanks:[Card.Rank],returnStrength:RankStrength)->Card.Rank{
        
        var rank:Card.Rank = .two
        
        switch returnStrength{
        case .Strongest:
            if let strongRank = lestRanks.min(){
                rank = strongRank
            }
        case .Stronger:
            // ハイカード・ワンペア・フラッシュで使用
            return lestRanks[1]
        case .Middle:
            return lestRanks[lestRanks.count/2]
        case .Weaker:
            // ハイカード・ワンペア・フラッシュで使用
            return lestRanks[3]
        case .Weakest:
            if let weakestRank = lestRanks.max(){
                rank =  weakestRank
            }
        }
        return rank
    }
    
    func checkStraightStrongRank(_ handStatus:HandStatus)->Card.Rank{
        
        var rank:Card.Rank = .five
        
        guard let contnuousRanks = handStatus.hand.hasContinuousRank.compactMap({$0.compactMap({$0.rank})}).last else {
            return rank
        }
        
        
        if contnuousRanks.contains(where: {$0 == .five}) &&
            contnuousRanks.contains(where: {$0 == .four}) &&
            contnuousRanks.contains(where: {$0 == .three}) &&
            contnuousRanks.contains(where: {$0 == .two}) &&
            contnuousRanks.contains(where: {$0 == .ace}){
            
            rank = .five
        } else {
            if let maxRank = contnuousRanks.max(){
                rank = maxRank
            }
        }
        
        return rank
    }
}
