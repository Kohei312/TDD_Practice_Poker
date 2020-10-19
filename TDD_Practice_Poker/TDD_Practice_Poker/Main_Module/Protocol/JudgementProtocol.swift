//
//  JudgementProtocol.swift
//  TDD_Practice_Poker
//
//  Created by kohei yoshida on 2020/10/07.
//

import Foundation

extension JudgementStatus{
    
    // 仮実装OK
    func compareCards(_ myHandStatus:Hand, otherHandStatus:Hand)->Judgement{
        
        let myHandState = myHandStatus.handState
        let myCards = myHandStatus.cards.compactMap({$0.rank}).sorted()
        let otherCards = otherHandStatus.cards.compactMap({$0.rank}).sorted()
        
        var state:Judgement = .draw
        
        // MARK:- checkLestRankの引数用
        // royalFlush以外で使用するため, switch外に配置
        var strengthCase = 0
        let rankStrength = RankStrength.allCases
        
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
            let myStrongPairRank = checkLestRank(myHandStatus.hasEqualRank.keys.prefix(1).map{$0}, returnStrength: .Strongest)
            let otherStrongPairRank = checkLestRank(otherHandStatus.hasEqualRank.keys.prefix(1).map{$0}, returnStrength: .Strongest)
            
            state = self.compareCardRanks(myCardRank: myStrongPairRank, otherCardRank: otherStrongPairRank)
            
            if state == .draw{
                
                // MARK:- 以降： ペア以外を比較
                // MARK:- 2回目： 最強ランクを比較(必ずsortして、昇順にしておくこと)

                let myLestCards = makeLestCardRanks(myHandStatus, reduceRanks: [myStrongPairRank])
                let otherLestCards = makeLestCardRanks(otherHandStatus, reduceRanks: [otherStrongPairRank])
                
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
                    let myLestCards = makeLestCardRanks(myHandStatus, reduceRanks: [myStrongPairRank,myWeakPairRank])
                    let otherLestCards = makeLestCardRanks(otherHandStatus, reduceRanks: [otherStrongPairRank,otherWeakPairRank])
                    
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
            // MARK:- 2回目： threePairを比較
            state = self.compareCardRanks(
                myCardRank: checkFullHousePairs(myHandStatus,returnPairType:.threeCard),
                otherCardRank: checkFullHousePairs(otherHandStatus,returnPairType:.threeCard))
            
            if state == .draw{
                // MARK:- 2回目： onePairを比較
                state = self.compareCardRanks(
                    myCardRank: checkFullHousePairs(myHandStatus,returnPairType:.onePair),
                    otherCardRank: checkFullHousePairs(otherHandStatus,returnPairType:.onePair))
            }
        case .royalFlush:
            state = .draw
            
        }
        
        return state
    }
    
    func compareCardRanks(myCardRank:Card.Rank,otherCardRank:Card.Rank)->Judgement{
        
        var currentState:Judgement = .draw
        
        print("カード比較 :")
        print("myRank :", myCardRank)
        print("otherRank :", otherCardRank)
        
        if myCardRank < otherCardRank{
            currentState = .lose
        } else if myCardRank > otherCardRank{
            currentState = .win
        } else if myCardRank == otherCardRank{
            currentState = .draw
        }
        
        return currentState
    }
    
    func makeLestCardRanks(_ handStatus:Hand,reduceRanks:[Card.Rank])->[Card.Rank]{
        
        var lestCardRanks:[Card.Rank] = []
        for reduceRank in reduceRanks{
            lestCardRanks = handStatus.cards.filter({$0.rank != reduceRank}).compactMap({$0.rank})
        }
        return lestCardRanks
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
    
    func checkTwoPairRank(_ handStatus:Hand,returnStrength:RankStrength)->Card.Rank{
        
        var rank:Card.Rank = .two
        
        switch returnStrength{
        case .Strongest:
            if let strongPair = handStatus.hasEqualRank.keys.max(),
               let strongPairRank = Card.Rank(rawValue: strongPair.rawValue){
                rank = strongPairRank
            }
        case .Stronger,.Middle,.Weaker:
            break
        case .Weakest:
            if let weakPair = handStatus.hasEqualRank.keys.min(),
               let weakPairRank = Card.Rank(rawValue: weakPair.rawValue){
                rank = weakPairRank
            }
        }
        
        return rank
    }
    
    func checkStraightStrongRank(_ handStatus:Hand)->Card.Rank{
        
        var rank:Card.Rank = .five
        
        let contnuousRanks = handStatus.hasContinuousRank
        if contnuousRanks == [.two,.three,.four,.five,.ace]{
            rank = .five
        } else {
            if let maxRank = contnuousRanks.max(){
                rank = maxRank
            }
        }
        return rank
    }

    func checkFullHousePairs(_ handStatus:Hand,returnPairType:HandState)->Card.Rank{
        
        var rank:Card.Rank = .two
        
        switch returnPairType{
        
        case .threeCard:
            if let myThreeCards = handStatus.hasEqualRank.filter({$0.value == .threeCard}).compactMap({$0}).last {
                rank = myThreeCards.key
            }
        case .onePair:
            if let myOnePair = handStatus.hasEqualRank.filter({$0.value == .onePair}).compactMap({$0}).last {
                rank = myOnePair.key
            }
        default:
            break
        }
        
        
        return rank
    }
}
