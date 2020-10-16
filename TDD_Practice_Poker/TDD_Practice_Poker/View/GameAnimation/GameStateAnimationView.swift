//
//  GameStateAnimationView.swift
//  TDD_Practice_Poker
//
//  Created by kohei yoshida on 2020/10/15.
//

import UIKit

enum ResultLabelState:String{
    case myPlayerSide = "Your Turn"
    case otherPlayerSide = "CPU's Turn"
    case readyBattle = "Battle Mode"
    case beforeJudge = "Judgement"
    case showJudge = ""
    
    func judgeText(judgement:Judgement)->String{
        switch judgement{
        case .win:
            return "You Win"
        case .draw:
            return "Draw"
        case .lose:
            return "You Lose"
        }
    }
}

enum AnimationItemFrame{
    case CPUHandStateLabel
    case ResultLabel
    case MyHandStateLabel
    
    func labelFrame(_ frame:CGRect)->CGRect{
        
        let size = CGSize(width: frame.width, height: frame.height / 3)
        
        switch self{
        case .CPUHandStateLabel:
            let origin = CGPoint(x: frame.minX, y: frame.minY)
            return CGRect(origin: origin, size: size)
        case .ResultLabel:
            let origin = CGPoint(x: frame.minX, y: frame.minY)
            return CGRect(origin: origin, size: size)
        case .MyHandStateLabel:
            let origin = CGPoint(x: frame.minX, y: (frame.minY))
            return CGRect(origin: origin, size: size)
        }
    }
}

class GameStateAnimationView: UIView {
    
    var otherHandStateLabel:UILabel?
    var resultLabel:UILabel?
    var myHandStateLabel:UILabel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .darkGray
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    
    private func setupItemLabels(itemFrame:AnimationItemFrame)->UILabel{
        return UILabel(frame: itemFrame.labelFrame(self.frame))
    }
    
    func addItemLabelsToAnimationBaseView(){
        let otherHandStateLabel = setupItemLabels(itemFrame: .CPUHandStateLabel)
        let resultLabel = setupItemLabels(itemFrame: .ResultLabel)
        let myHandStateLabel = setupItemLabels(itemFrame: .MyHandStateLabel)
        
        self.otherHandStateLabel = otherHandStateLabel
        self.resultLabel = resultLabel
        self.myHandStateLabel = myHandStateLabel
        
        self.addSubview(self.otherHandStateLabel!)
        self.addSubview(self.resultLabel!)
        self.addSubview(self.myHandStateLabel!)
        
        setupConstraint()
    }
    
    func setupConstraint(){
        guard let otherLabel = otherHandStateLabel,
              let resultLabel = resultLabel,
              let myLabel = myHandStateLabel else {return}
        
        labelConstraint(label: otherLabel, labelType: .CPUHandStateLabel)
        labelConstraint(label: resultLabel, labelType: .ResultLabel)
        labelConstraint(label: myLabel, labelType: .MyHandStateLabel)
        
        self.otherHandStateLabel = otherLabel
        self.resultLabel = resultLabel
        self.myHandStateLabel = myLabel

    }
    
    func labelConstraint(label:UILabel, labelType:AnimationItemFrame){
        label.translatesAutoresizingMaskIntoConstraints = false
        label.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        label.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        label.heightAnchor.constraint(equalToConstant: label.frame.height / 2).isActive = true
        
        switch labelType{
        case .CPUHandStateLabel:
            label.topAnchor.constraint(equalTo: self.topAnchor,constant: 8).isActive = true
        case .ResultLabel:
            label.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        case .MyHandStateLabel:
            label.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: -8).isActive = true
        }
        
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 24.0)
        label.isHidden = false
        label.alpha = 1
    }
    
    func setupItemLabelText(itemFrame:AnimationItemFrame,result:ResultLabelState,judgement:Judgement?,hand:Hand?){
        
        var itemLabel:UILabel = UILabel()
        
        switch itemFrame{
        case .CPUHandStateLabel:
            if let label = self.otherHandStateLabel{
                itemLabel = label
            }
        case .ResultLabel:
            if let label = self.resultLabel{
                itemLabel = label
            }
        case .MyHandStateLabel:
            if let label = self.myHandStateLabel{
                itemLabel = label
            }
        }
        
        
        switch result{
        case .myPlayerSide, .otherPlayerSide, .readyBattle, .beforeJudge:
            itemLabel.text = result.rawValue
        case .showJudge:
            switch itemFrame{
            case .CPUHandStateLabel, .MyHandStateLabel:
                guard let hand = hand else {return}
                itemLabel.text = String(describing:hand.handState)
            case .ResultLabel:
                guard let judge = judgement else {return}
                itemLabel.text = result.judgeText(judgement: judge)
            }
        }
    }
    
    func showJudge(itemFrame:AnimationItemFrame,judgement:Judgement?,myHand:Hand,otherHand:Hand){
        self.setupItemLabelText(itemFrame:.ResultLabel,result:.showJudge,judgement:judgement,hand:nil)
        self.setupItemLabelText(itemFrame:.MyHandStateLabel,result:.showJudge,judgement:nil,hand:myHand)
        self.setupItemLabelText(itemFrame:.CPUHandStateLabel,result:.showJudge,judgement:nil,hand:otherHand)
        self.shouldAppearAnimationView(true)
    }
    
//    func showHandState(hand:Hand)->([Card],HandState){
//        let i = String(describing:hand.handState)
//        return (hand.cards,hand.handState)
//    }
}


