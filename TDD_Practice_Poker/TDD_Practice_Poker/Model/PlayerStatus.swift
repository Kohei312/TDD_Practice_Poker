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
                state = .win
            } else if myHandStatus.handState == otherHandStatus.handState{
                state = self.compareCards(myHandStatus,otherHandStatus:otherHandStatus)
            }
        }
        
        return state
    }
    
    // 仮実装OK
    func compareCards(_ myHandStatus:HandStatus, otherHandStatus:HandStatus)->PlayerState{
        
        let handState = myHandStatus.handState
        let myCards = myHandStatus.hand.cards
        let otherCards = otherHandStatus.hand.cards
        
        guard let myStrongCard = myCards.compactMap({$0.rank}).max(),
              let otherStrongCard = otherCards.compactMap({$0.rank}).max(),
              let myWeakCard = myCards.compactMap({$0.rank}).min(),
              let otherWeakCard = otherCards.compactMap({$0.rank}).min() else {return .inPlaying}

        
        var state:PlayerState = .inPlaying
        
        switch handState{
        case .nothing:
            break
        case .highCard:
            state = self.compareCardRanks(myCard: myStrongCard, otherCard: otherStrongCard)
            if state == .draw{
                state = self.compareCardRanks(myCard: myWeakCard, otherCard: otherWeakCard)
            }
            break
        case .pair:
            state = self.compareCardRanks(myCard: myStrongCard, otherCard: otherStrongCard)
            if state == .draw{
                state = self.compareCardRanks(myCard: myWeakCard, otherCard: otherWeakCard)
            }
            break
        case .straight:
            state = self.compareCardRanks(myCard: myStrongCard, otherCard: otherStrongCard)
            break
        case.flush:
            state = self.compareCardRanks(myCard: myStrongCard, otherCard: otherStrongCard)
            if state == .draw{
                state = self.compareCardRanks(myCard: myWeakCard, otherCard: otherWeakCard)
            }
            break
        case .straightFlush:
            state = self.compareCardRanks(myCard: myStrongCard, otherCard: otherStrongCard)
            break
        }
        
        return state
    }
    
    func compareCardRanks(myCard:Card.Rank,otherCard:Card.Rank)->PlayerState{
        
        var currentState:PlayerState = .draw
 
        if myCard < otherCard{
            currentState = .lose
        } else if myCard > otherCard{
            currentState = .win
        } else if myCard == otherCard{
            currentState = .draw
        }
        
        return currentState
    }
    
    
    
}
