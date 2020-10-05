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

        guard let myStrongCard = myCards.max(),
              let otherStrongCard = otherCards.max(),
              let myWeakCard = myCards.min(),
              let otherWeakCard = otherCards.min() else {return .inPlaying}
        
        var state:PlayerState = .inPlaying
        
        switch handState{
        case .nothing:
            break
        case .highCard:

            state = self.compareCardRanks(myCard: myStrongCard, otherCard: otherStrongCard)
            if state == .draw{

                let myMiddleCard = myCards[(myCards.count - 1) / 2]
                let otherMiddleCard = otherCards[(otherCards.count - 1) / 2]

                state = self.compareCardRanks(myCard: myMiddleCard, otherCard: otherMiddleCard)
                
                if state == .draw{
                    state = self.compareCardRanks(myCard: myWeakCard, otherCard: otherWeakCard)
                }
            }
            break
        case .onePair:
            // MARK:- 1回目： 強いペアを比較
            let myPairCards = myHandStatus.hand.hasEqualRank
            let otherPairCards = otherHandStatus.hand.hasEqualRank
            
            let myStrongRank = checkPairRank(myPairCards,returnStrength: .Strong)
            let otherStrongRank = checkPairRank(otherPairCards,returnStrength: .Strong)
              
            state = self.compareCardRanks(myCard: myStrongRank, otherCard: otherStrongRank)
                
                if state == .draw{
                    
                    // MARK:- 2回目： 弱いペアを比較
                    let myWeakRank = checkPairRank(myPairCards,returnStrength: .Weak)
                    let otherWeakRank = checkPairRank(otherPairCards,returnStrength: .Weak)
                    
                    state = self.compareCardRanks(myCard: myWeakRank, otherCard: otherWeakRank)
                    
                    if state == .draw{
                        // MARK:- 3回目： そのほかのカードを比較
                        let myLestCardRank = checkLestRank( myHandStatus,strongRank:myStrongRank,weakRank:myWeakRank,returnStrength:.Strong)
                        let otherLestCardRank = checkLestRank( otherHandStatus,strongRank:otherStrongRank,weakRank:otherWeakRank,returnStrength:.Strong)

                        state = self.compareCardRanks(myCard: myLestCardRank, otherCard: otherLestCardRank)


                    }
                    
                }
 
            break
        case.flush:
 
            state = self.compareCardRanks(myCard: myStrongCard, otherCard: otherStrongCard)
            if state == .draw{
                
                let myMiddleCard = myCards[(myCards.count - 1) / 2]
                let otherMiddleCard = otherCards[(otherCards.count - 1) / 2]

                state = self.compareCardRanks(myCard: myMiddleCard, otherCard: otherMiddleCard)
                if state == .draw{
                    state = self.compareCardRanks(myCard: myWeakCard, otherCard: otherWeakCard)
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
            
            state = self.compareCardRanks(myCard: myRank, otherCard: otherRank)
            break
            
        case.threeCard:
  
            state = self.compareCardRanks(myCard: myStrongCard, otherCard: otherStrongCard)
            if state == .draw{
                state = self.compareCardRanks(myCard: myWeakCard, otherCard: otherWeakCard)
            }
            break
            
        case .straightFlush:
   
            var myRank:Card.Rank{
                checkStraightStrongRank(myHandStatus)
            }
            var otherRank:Card.Rank{
                checkStraightStrongRank(otherHandStatus)
            }

            
            state = self.compareCardRanks(myCard: myRank, otherCard: otherRank)
            break
        case .twoPair:
            break
        case .fullHouse:
            break
        case .fourCard:
            break
        case .royalFlush:
            break
        }
        
        return state
    }
    
    func compareCardRanks(myCard:Card.Rank?,otherCard:Card.Rank?)->PlayerState{
//        print("カード比較 :")
//        print("myCard :", myCard)
//        print("otherCard :", otherCard)
        
        var currentState:PlayerState = .draw
        
        guard let myRank = myCard else {
            currentState = .lose
            return currentState
        }
        
        guard let otherRank = otherCard else {
            currentState = .win
            return currentState
        }
        
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
    
    func checkPairRank(_ pairCards:[[Card]],returnStrength:RankStrength)->Card.Rank{
        
        var rank:Card.Rank = .two
        
        switch returnStrength{
        case .Weak:
            guard let weakRank = pairCards.compactMap({$0.min{a,b in a.rank < b.rank}}).last?.rank else{return rank}
            rank = weakRank
        case .Middle:
        break
        case .Strong:
            guard let strongRank = pairCards.compactMap({$0.max{a,b in a.rank < b.rank}}).last?.rank else{return rank}
            rank = strongRank
        case .Others:
        break
        }
        return rank
    }
    
    func checkLestRank(_ handStatus:HandStatus,strongRank:Card.Rank,weakRank:Card.Rank,returnStrength:RankStrength)->Card.Rank{
        
        
        let lestRanks = handStatus.hand.cards.filter({$0.rank != strongRank && $0.rank != weakRank}).compactMap({$0.rank}).sorted()
        
        var rank:Card.Rank = .two
        
        switch returnStrength{
        case .Weak:
            guard let weakRank = lestRanks.first else {return rank}
            rank = weakRank
        case .Middle:
            rank = lestRanks[lestRanks.count/2]
        break
        case .Strong:
            guard let strongRank = lestRanks.last else {return rank}
            rank = strongRank
        case .Others:
        break
        }
        return rank
    }
    
    func checkStraightStrongRank(_ handStatus:HandStatus)->Card.Rank{
        
        var rank:Card.Rank = .three
        
        guard let contnuousRanks = handStatus.hand.hasContinuousRank.compactMap({$0.compactMap({$0.rank})}).last else {
            return rank
        }
        
                
        if contnuousRanks.contains(where: {$0 == .three}) &&
            contnuousRanks.contains(where: {$0 == .two}) &&
            contnuousRanks.contains(where: {$0 == .ace}){
            
            rank = .three
        } else {
            if let maxRank = contnuousRanks.max(){
                rank = maxRank
            }
        }
        
        return rank
    }
}
