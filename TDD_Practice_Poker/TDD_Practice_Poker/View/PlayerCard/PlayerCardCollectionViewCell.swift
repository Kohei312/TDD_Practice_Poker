//
//  PlayerCardCollectionViewCell.swift
//  TDD_Practice_Poker
//
//  Created by kohei yoshida on 2020/10/12.
//

import UIKit

class PlayerCardCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var suitLabel: UILabel!
    @IBOutlet weak var rankLabel: UILabel!
    var cardChangeState: ChangeCardState = .canChange
    var cardHashValue: Int?
    
    override func prepareForReuse() {
        suitLabel.text = nil
        rankLabel.text = nil
    }
    
    func setupPlayerCardCellColor(color:UIColor){
        self.contentView.backgroundColor = color
    }
        
    func setCardHashValue(cardHashValue:Int){
        self.cardHashValue = cardHashValue
    }
    
    func setupLabels(suit:String,rank:String){
        self.suitLabel.text = suit
        self.rankLabel.text = rank
    }
    
    func setupCardChangeStatus(_ cardState:ChangeCardState){
        self.cardChangeState = cardState
    }
    
}
