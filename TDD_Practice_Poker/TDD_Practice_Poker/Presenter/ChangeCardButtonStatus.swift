//
//  ChangeCardButtonStatus.swift
//  TDD_Practice_Poker
//
//  Created by kohei yoshida on 2020/10/13.
//

import Foundation

enum ChangeCardButtonState{
    case canChange
    case cannotChange
}

struct ChangeCardButtonStatus{
    
    var currentState:ChangeCardButtonState = .cannotChange
 
    mutating func changeCardButtonStatus()->Bool{
        switch currentState {
        case .canChange:
            self.currentState = .cannotChange
            return false
        case .cannotChange:
            self.currentState = .canChange
            return true
        }
    }
}
