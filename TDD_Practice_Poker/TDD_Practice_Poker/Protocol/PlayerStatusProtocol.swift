//
//  PlayerStatusProtocol.swift
//  TDD_Practice_Poker
//
//  Created by kohei yoshida on 2020/10/06.
//

import Foundation

extension PlayerStatus{
    
    // 仮実装OK
    func compareCards(_ myHandStatus:HandStatus, otherHandStatus:HandStatus)->PlayerState{
        
        let myHandState = myHandStatus.handState
        let myCards = myHandStatus.hand.cards.compactMap({$0.rank}).sorted()
        let otherCards = otherHandStatus.hand.cards.compactMap({$0.rank}).sorted()
        
        var state:PlayerState = .inPlaying
        
        // MARK:- checkLestRankの引数用
        // royalFlush以外で使用するため, switch外に配置
        var strengthCase = 0
        var rankStrength = RankStrength.allCases
        
        switch myHandState{
        case .nothing:
            break
        case .highCard,.flush:
            
            state = self.compareCardRanks(myCardRank: checkLestRank(myCards, returnStrength: rankStrength[strengthCase]), otherCardRank: checkLestRank(otherCards, returnStrength: rankStrength[strengthCase]))
            
            while state == .draw{
                strengthCase += 1
                if strengthCase == 5{
                    strengthCase = 0
                    break
                }
                state = self.compareCardRanks(myCardRank: checkLestRank(myCards, returnStrength: rankStrength[strengthCase]), otherCardRank: checkLestRank(otherCards, returnStrength: rankStrength[strengthCase]))
            }
            
        case .onePair,.threeCard,.fourCard:
            // MARK:- 1回目： ペアを比較
            guard
                let myPairCards = myHandStatus.hand.hasEqualRank.keys.max(),
                let myStrongPairRank = Card.Rank(rawValue: myPairCards.rawValue),
                let otherPairCards = otherHandStatus.hand.hasEqualRank.keys.max(),
                let otherStrongPairRank = Card.Rank(rawValue: otherPairCards.rawValue)
            else { return .draw }
            
            state = self.compareCardRanks(myCardRank: myStrongPairRank, otherCardRank: otherStrongPairRank)
            
            if state == .draw{
                
                // MARK:- 以降： ペア以外を比較
                // MARK:- 2回目： 最強ランクを比較(必ずsortして、昇順にしておくこと)
                let myLestCards = myHandStatus.hand.cards.filter({$0.rank != myStrongPairRank}).compactMap({$0.rank}).sorted()
                let otherLestCards = otherHandStatus.hand.cards.filter({$0.rank != otherStrongPairRank}).compactMap({$0.rank}).sorted()
                
                while state == .draw{
                    
                    state = self.compareCardRanks(myCardRank: checkLestRank(myLestCards, returnStrength: rankStrength[strengthCase]), otherCardRank: checkLestRank(otherLestCards, returnStrength: rankStrength[strengthCase]))
                    
                    if (strengthCase == 0 && myHandState == .fourCard) ||
                        (strengthCase == 2 && myHandState == .threeCard) ||
                        (strengthCase == 4 && myHandState == .onePair){
                        
                        strengthCase = 0
                        break
                    }
                    strengthCase += 2
                    
                }
            }
            

        case .twoPair:
            // MARK:- 1回目： 強いペアを比較            
            let myStrongPairRank = checkTwoPairRank(myHandStatus, returnStrength: .Strongest)
            let otherStrongPairRank = checkTwoPairRank(otherHandStatus, returnStrength: .Strongest)
            
            state = self.compareCardRanks(myCardRank: myStrongPairRank,otherCardRank: otherStrongPairRank)
            
            if state == .draw{
                
                // MARK:- 2回目： 弱いペアを比較
                let myWeakPairRank = checkTwoPairRank(myHandStatus, returnStrength: .Weakest)
                let otherWeakPairRank = checkTwoPairRank(otherHandStatus, returnStrength: .Weakest)
                
                
                state = self.compareCardRanks(myCardRank: myWeakPairRank,otherCardRank: otherWeakPairRank)
                
                if state == .draw{
                    // MARK:- 3回目： 2ペア以外の最強ランクを比較
                    let myLestCards = myHandStatus.hand.cards.filter({$0.rank != myStrongPairRank && $0.rank != myWeakPairRank}).compactMap({$0.rank})
                    let otherLestCards = otherHandStatus.hand.cards.filter({$0.rank != otherStrongPairRank && $0.rank != otherWeakPairRank}).compactMap({$0.rank})
                    
                    state = self.compareCardRanks(myCardRank: checkLestRank(myLestCards, returnStrength: .Strongest), otherCardRank: checkLestRank(otherLestCards, returnStrength: .Strongest))
                }
            }
            
            
        case .straight,.straightFlush:
            
            var myRank:Card.Rank{
                checkStraightStrongRank(myHandStatus)
            }
            var otherRank:Card.Rank{
                checkStraightStrongRank(otherHandStatus)
            }
            
            state = self.compareCardRanks(myCardRank: myRank, otherCardRank: otherRank)
            
        case .fullHouse:
            guard let myThreeCards = myHandStatus.hand.hasEqualRank.filter({$0.value == .threeCard}).compactMap({$0}).last,
                  let otherThreeCards = otherHandStatus.hand.hasEqualRank.filter({$0.value == .threeCard}).compactMap({$0}).last else{
                return .draw
            }
            
            let myStrongThreeRank = myThreeCards.key
            let otherStrongThreeRank = otherThreeCards.key
            
            state = self.compareCardRanks(myCardRank: myStrongThreeRank, otherCardRank: otherStrongThreeRank)
            
            if state == .draw{
                
                // MARK:- 2回目： 弱いペアを比較
                guard let myPairCards = myHandStatus.hand.hasEqualRank.filter({$0.value == .onePair}).compactMap({$0}).last,
                      let otherPairCards = otherHandStatus.hand.hasEqualRank.filter({$0.value == .onePair}).compactMap({$0}).last else{
                    return .draw
                }
                
                let myStrongPairRank = myPairCards.key
                let otherStrongPairRank = otherPairCards.key
                
                state = self.compareCardRanks(myCardRank: myStrongPairRank, otherCardRank: otherStrongPairRank)
            }
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
    
    // ハイカード・ワンペア・フラッシュで使用
    // 引数のlestRankには、Pairを取り除いた配列を入れる
    func checkLestRank(_ lestRanks:[Card.Rank],returnStrength:RankStrength)->Card.Rank{
        
        var rank:Card.Rank = .two
        
        switch returnStrength{
        case .Strongest:
            if let strongRank = lestRanks.max(){
                rank = strongRank
            }
        case .Stronger:
            // ハイカード・フラッシュで使用
            return lestRanks[1]
        case .Middle:
            print("rank :\(lestRanks[(lestRanks.count-1)/2]) ,  lestRanks :\(lestRanks)")
            return lestRanks[(lestRanks.count-1)/2]
        case .Weaker:
            // ハイカード・フラッシュで使用
            return lestRanks[3]
        case .Weakest:
            if let weakestRank = lestRanks.min(){
                rank =  weakestRank
            }
        }
        return rank
    }
    
    func checkTwoPairRank(_ handStatus:HandStatus,returnStrength:RankStrength)->Card.Rank{
        
        var rank:Card.Rank = .two
        
        switch returnStrength{
        case .Strongest:
            if let strongPair = handStatus.hand.hasEqualRank.keys.max(),
               let strongPairRank = Card.Rank(rawValue: strongPair.rawValue){
                rank = strongPairRank
            }
        case .Stronger,.Middle,.Weaker:
            break
        case .Weakest:
            if let weakPair = handStatus.hand.hasEqualRank.keys.min(),
               let weakPairRank = Card.Rank(rawValue: weakPair.rawValue){
                rank = weakPairRank
            }
        }
        
        return rank
    }
    
    func checkStraightStrongRank(_ handStatus:HandStatus)->Card.Rank{
        
        var rank:Card.Rank = .five
        
        let contnuousRanks = handStatus.hand.hasContinuousRank
        if contnuousRanks == [.two,.three,.four,.five,.ace]{
            rank = .five
        } else {
            if let maxRank = contnuousRanks.max(){
                rank = maxRank
            }
        }
        
        return rank
    }
}
