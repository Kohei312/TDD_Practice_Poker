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

    override func prepareForReuse() {
        suitLabel.text = nil
        rankLabel.text = nil
    }
        
    
    func setupPlayerCardCellColor(color:UIColor){
        self.contentView.backgroundColor = color
    }

}
