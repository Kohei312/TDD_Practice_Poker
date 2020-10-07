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

struct JudgementStatus:JudgementStatusProtocol{
    
    #warning("ここにUIの状態管理を行うPresenterのprotocolをDI")
    /*
     var dependency:PresenterClass?
     
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
