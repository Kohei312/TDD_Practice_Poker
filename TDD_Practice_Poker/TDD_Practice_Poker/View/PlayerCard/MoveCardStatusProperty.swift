//
//  MoveCardStatusProperty.swift
//  TDD_Practice_Poker
//
//  Created by kohei yoshida on 2020/10/14.
//

import Foundation

enum ChangeCardState{
    case canChange
    case cannotChange
}

struct MoveCardStatusProperty {
    var cardStatuses:[IndexPath:ChangeCardState] = [:]
    
    mutating func resetCardStatus(){
        self.cardStatuses = [:]
    }
}
