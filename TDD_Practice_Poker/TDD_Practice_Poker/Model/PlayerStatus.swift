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
                state = self.compareCardRanks(myHandStatus,otherHandStatus:otherHandStatus)
            }
        }
        
        return state
    }
    
    // 仮実装OK
    func compareCardRanks(_ myHandStatus:HandStatus, otherHandStatus:HandStatus)->PlayerState{
        
        let handState = myHandStatus.handState
        let myCards = myHandStatus.hand.cards
        let otherCards = otherHandStatus.hand.cards
        
        guard let myStrongCard = myCards.compactMap({$0.rank}).max(),
              let otherStrongCard = otherCards.compactMap({$0.rank}).max(),
              let myWeakCard = myCards.compactMap({$0.rank}).min(),
              let otherWeakCard = otherCards.compactMap({$0.rank}).min() else {return .inPlaying}
        
        var state:PlayerState = .draw
        
        switch handState{
        case .nothing:
            break
        case .highCard:
            
            if myStrongCard < otherStrongCard{
                state = .lose
            } else if myStrongCard > otherStrongCard{
                state = .win
            } else if (myStrongCard == otherStrongCard) && myWeakCard < otherWeakCard{
                state = .lose
            } else if (myStrongCard == otherStrongCard) && myWeakCard > otherWeakCard{
                state = .win
            } else if (myStrongCard == otherStrongCard) && myWeakCard == otherWeakCard{
                state = .draw
            }
            break
        case .pair:
            
            if myStrongCard < otherStrongCard{
                state = .lose
            } else if myStrongCard > otherStrongCard{
                state = .win
            } else if (myStrongCard == otherStrongCard) && myWeakCard < otherWeakCard{
                state = .lose
            } else if (myStrongCard == otherStrongCard) && myWeakCard > otherWeakCard{
                state = .win
            } else if (myStrongCard == otherStrongCard) && myWeakCard == otherWeakCard{
                state = .draw
            }

            break
        case .straight:
            if myStrongCard < otherStrongCard{
                state = .lose
            } else if myStrongCard > otherStrongCard{
                state = .win
            } else if (myStrongCard == otherStrongCard){
                state = .draw
            }

            break
        case.flush:
            if myStrongCard < otherStrongCard{
                state = .lose
            } else if myStrongCard > otherStrongCard{
                state = .win
            } else if (myStrongCard == otherStrongCard) && myWeakCard < otherWeakCard{
                state = .lose
            } else if (myStrongCard == otherStrongCard) && myWeakCard > otherWeakCard{
                state = .win
            } else if (myStrongCard == otherStrongCard) && myWeakCard == otherWeakCard{
                state = .draw
            }
            break
        case .straightFlush:
            if myStrongCard < otherStrongCard{
                state = .lose
            } else if myStrongCard > otherStrongCard{
                state = .win
            } else if (myStrongCard == otherStrongCard){
                state = .draw
            }
            break
        }
        
        return state
// 仮実装OK
//        return .draw
    }
    
    
    
}
