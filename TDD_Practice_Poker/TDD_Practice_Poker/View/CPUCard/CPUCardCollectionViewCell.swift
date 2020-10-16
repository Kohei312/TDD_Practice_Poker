//
//  CPUCardCollectionViewCell.swift
//  TDD_Practice_Poker
//
//  Created by kohei yoshida on 2020/10/12.
//

import UIKit

class CPUCardCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var cpuSuitLabel: UILabel!
    @IBOutlet weak var cpuRankLabel: UILabel!
    
    func setupCPUCardCellColor(color:UIColor){
        self.contentView.backgroundColor = color
    }
    
    func changeCPUCard(){
        self.shouldUpdateCPUCard(false)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.shouldUpdateCPUCard(true)
        }
    }
    
    func openCPUCard(card:Card){
        self.shouldUpdateCPUCard(false)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.cpuSuitLabel.text = card.suit.rawValue
            self.cpuRankLabel.text = card.rank.rawValue
            self.cpuSuitLabel.isHidden = false
            self.cpuRankLabel.isHidden = false
            self.shouldUpdateCPUCard(true)
        }
    }
}
