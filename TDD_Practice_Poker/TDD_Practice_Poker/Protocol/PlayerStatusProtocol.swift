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
        
        let handState = myHandStatus.handState
        let myCards = myHandStatus.hand.cards.compactMap({$0.rank}).sorted()
        let otherCards = otherHandStatus.hand.cards.compactMap({$0.rank}).sorted()
        
        var state:PlayerState = .inPlaying
        
        switch handState{
        case .nothing:
            break
        case .highCard,.flush:
            
            var strengthCase = 0
            let rankStrength = RankStrength.allCases[strengthCase]
            
            state = self.compareCardRanks(myCardRank: checkLestRank(myCards, returnStrength: rankStrength), otherCardRank: checkLestRank(otherCards, returnStrength: rankStrength))
            
            while state == .draw{
                strengthCase += 1
                if strengthCase == 5{
                    break
                }
                state = self.compareCardRanks(myCardRank: checkLestRank(myCards, returnStrength: rankStrength), otherCardRank: checkLestRank(otherCards, returnStrength: rankStrength))
            }
            
        case .onePair,.threeCard,.fourCard:
            // MARK:- 1回目： ペアを比較
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
                
                if state == .draw && handState == .fourCard{
                    break
                } else if state == .draw && (handState == .onePair || handState == .threeCard){
                    // MARK:- 3回目： 中間のカードを比較
                    state = self.compareCardRanks(myCardRank: checkLestRank(myLestCards, returnStrength: .Middle), otherCardRank: checkLestRank(otherLestCards, returnStrength: .Middle))
                    
                    if state == .draw && handState == .onePair{
                        // MARK:- 4回目： 最弱のカードを比較
                        state = self.compareCardRanks(myCardRank: checkLestRank(myLestCards, returnStrength: .Weakest), otherCardRank: checkLestRank(otherLestCards, returnStrength: .Weakest))
                    }
                    
                }
            }
        case .twoPair:
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
                
                // MARK:- 2回目： 弱いペアを比較
                guard let myPairCards = myHandStatus.hand.hasEqualRank.keys.min(),
                      let myWeakPairRank = Card.Rank(rawValue: myPairCards.rawValue) else{
                    return .draw
                }
                guard let otherPairCards = otherHandStatus.hand.hasEqualRank.keys.min(),
                      let otherWeakPairRank = Card.Rank(rawValue: otherPairCards.rawValue) else{
                    return .draw
                }
                
                state = self.compareCardRanks(myCardRank: myWeakPairRank, otherCardRank: otherWeakPairRank)
                
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
            if let strongRank = lestRanks.min(){
                rank = strongRank
            }
        case .Stronger:
            // ハイカード・フラッシュで使用
            return lestRanks[1]
        case .Middle:
            return lestRanks[(lestRanks.count-1)/2]
        case .Weaker:
            // ハイカード・フラッシュで使用
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
        
        let contnuousRanks = handStatus.hand.hasContinuousRank
        
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
