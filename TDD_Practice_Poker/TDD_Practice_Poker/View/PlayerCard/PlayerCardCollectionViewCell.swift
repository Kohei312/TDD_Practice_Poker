//
//  PlayerCardCollectionViewCell.swift
//  TDD_Practice_Poker
//
//  Created by kohei yoshida on 2020/10/12.
//

import UIKit

enum ChangeCardState{
    case canChange
    case cannotChange
}

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
    
    func switchCardTouchState()->Bool{
        switch cardChangeState{
        case .canChange:
            return true
        case .cannotChange:
            return false
        }
    }
    
    func setCardHashValue(cardHashValue:Int){
        self.cardHashValue = cardHashValue
    }
    
}
