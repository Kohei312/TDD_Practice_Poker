//
//  CircleMenuBuilder.swift
//  TDD_Practice_Poker
//
//  Created by kohei yoshida on 2020/10/14.
//

import Foundation
import CircleMenu

extension PokerViewController:CircleMenuDelegate{
    
    func setupMenuButton(){
        let button = CircleMenu(
            frame: CGRect(x:0,y:0,width: 50, height: 50),
            normalIcon:"ButtonMenu/MenuIcon",
            selectedIcon:"ButtonMenu/MenuIcon",
            buttonsCount: 4,
            duration: 0.5,
            distance: 90)
        
        button.backgroundColor = UIColor.systemBlue
        button.delegate = self
        button.layer.cornerRadius = button.frame.size.width / 2
        
        guard let cv = self.playerCardCollectionView else { fatalError("PlayerCollectionView not found")}
        let fibonuchThirdSquareLength = min(cv.frame.width / 4, cv.frame.height / 4)
        
        view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.trailingAnchor.constraint(equalTo: self.playerCardCollectionView.trailingAnchor,constant: -8).isActive = true
        button.bottomAnchor.constraint(equalTo: self.playerCardCollectionView.bottomAnchor, constant: -fibonuchThirdSquareLength + 8).isActive = true
        
        button.widthAnchor.constraint(equalToConstant: 50).isActive = true
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        self.circleMenuButton = button
    }
    
    func circleMenu(_: CircleMenu, willDisplay button: UIButton, atIndex: Int) {
        
        switch circleMenuButtonProperty.gameSide{
        
        case .playerType(_),.result:
            button.isHidden = false
        case .beforeJudgement:
            if atIndex != 2 {
                button.isHidden = true
            }
        }
        
        if atIndex == 0{
            changePlayerCollectionViewDragEnable(nextGameSide: .playerType(.other))
        }
        
        button.backgroundColor = circleMenuButtonProperty.items[atIndex].color
        
        button.setImage(UIImage(named: circleMenuButtonProperty.items[atIndex].icon)?.resized(toWidth:45), for: .normal)
        // set highlited image
        let highlightedImage = UIImage(named: circleMenuButtonProperty.items[atIndex].icon)?.withRenderingMode(.alwaysTemplate)
        button.setImage(highlightedImage, for: .highlighted)
        
        button.tintColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
    }
    
    func menuCollapsed(_ circleMenu: CircleMenu) {
        print("button will be collapsed")
        changePlayerCollectionViewDragEnable(nextGameSide: .playerType(.me))
    }
    
    func circleMenu(_: CircleMenu, buttonWillSelected _: UIButton, atIndex: Int) {}
    
    func circleMenu(_: CircleMenu, buttonDidSelected _: UIButton, atIndex: Int) {
        print("button did selected: \(atIndex)")
        // ボタンのアニメーション終了後に呼ばれる
        
        changePlayerCollectionViewDragEnable(nextGameSide: .playerType(.other)) // メニューボタンを押した直後に.falseとなっているため、ここで一瞬.trueにもどす
        switch atIndex{
        case 0:
            // MARK:- バトル開始: atIndex = 0
            self.pokerPresenter?.willChangeUserStatus(.tappedBattleBtn)
        case 1:
            // MARK:- 捨て: atIndex = 1
            break
        case 2:
            // MARK:- リスタート: atIndex = 2
            self.pokerPresenter?.willChangeUserStatus(.tappedRestartBtn)
        case 3:
            // MARK:- ターン終了: atIndex = 3
            
            self.pokerPresenter?.willChangeUserStatus(.tappedTurnoverBtn)
            self.moveCardStatuses.resetCardStatus()
            for cell in self.playerCardCollectionView.visibleCells(with: PlayerCardCollectionViewCell.self){
                cell.cardChangeState = .canChange
            }
            
        default:
            break
        }
        
    }
    
}

