//
//  JudgementStatus.swift
//  TDD_Practice_Poker
//
//  Created by kohei yoshida on 2020/10/07.
//

import Foundation

protocol JudgementStatusProtocol {
    func willStartJudge()
    func notifyResult()
}

// MARK:- プレーヤー同士の役を比べて勝敗をつける
struct JudgementStatus:JudgementStatusProtocol{
    
    #warning("ここにUIの状態管理を行うPresenterのprotocolをDI")
    /*
     var dependency:PresenterClass?

     // これは別途、Containerにまとめていく予定
     // let judgement = Judgement(
     
     init(dependency:){
        self.dependency = dependency
     }
     */
    

    
    func willStartJudge() {
        
    }
    
    func notifyResult() {
        #warning("DIしたPresenterへ結果を返却")
//        dependency?.hogehoge()
    }
    
}
