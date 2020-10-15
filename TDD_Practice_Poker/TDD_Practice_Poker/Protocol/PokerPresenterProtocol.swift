//
//  PokerPresenterProtocol.swift
//  TDD_Practice_Poker
//
//  Created by kohei yoshida on 2020/10/15.
//

import Foundation

protocol PokerPresenterOutputProtocol{
    func updateJudgementUI(judgement:Judgement,myHand:Hand,otherHand:Hand)
    func updateGameStateUI()
    //    func updatePlayerUI()
}
