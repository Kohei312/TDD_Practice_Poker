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
            buttonsCount: 2,
            duration: 0.5,
            distance: 75)

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
    
    func circleMenu(_: CircleMenu, buttonWillSelected _: UIButton, atIndex: Int) {
        print("button will selected: \(atIndex)")
        // ボタンをタップした瞬間にコールされる
        // MARK:- ターン終了: atIndex = 0
        // 交換したカードが表示される時間
        
         
//        if atIndex == 0{
//            shouldAppearAnimationView(true,view:self.animationView)
//        } else if atIndex == 1{
//            shouldAppearAnimationView(false,view:self.animationView)
//        }

        // MARK:- バトル開始: atIndex = 1
        // バトル宣言をしたことが表示される時間
        
    }
    
    func circleMenu(_: CircleMenu, buttonDidSelected _: UIButton, atIndex: Int) {
        print("button did selected: \(atIndex)")
        // ボタンのアニメーション終了後に呼ばれる

        changePlayerCollectionViewDragEnable(nextGameSide: .playerType(.other)) // メニューボタンを押した直後に.falseとなっているため、ここで一瞬.trueにもどす
        switch atIndex{
        case 0:
            // MARK:- ターン終了: atIndex = 0
            self.pokerPresenter?.tappedTurnoverBtn(.me)
        case 1:
            // MARK:- バトル開始: atIndex = 1
            self.pokerPresenter?.tappedBattleBtn(.me)
        default :break
        }
        
    }

}

