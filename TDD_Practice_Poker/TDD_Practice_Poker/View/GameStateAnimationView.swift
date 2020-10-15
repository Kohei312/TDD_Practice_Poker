//
//  GameStateAnimationView.swift
//  TDD_Practice_Poker
//
//  Created by kohei yoshida on 2020/10/15.
//

import UIKit

class GameStateAnimationView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = .darkGray

        makeShapeLayer()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func makeShapeLayer() {

        let path = UIBezierPath()
        
        // ここで図形描画
        path.move(to: CGPoint(x: self.frame.width/2, y: 0.0))
        path.addLine(to: CGPoint(x: 0.0, y: self.frame.size.height))
        path.addLine(to: CGPoint(x: self.frame.size.width, y: self.frame.size.height))
        path.close()

        // pathの設定は無視される
        UIColor.red.setFill()
        path.fill()

        UIColor.blue.setStroke()
        path.stroke()

        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath

        // 設定しないと黒
        shapeLayer.fillColor = UIColor.orange.cgColor
        shapeLayer.strokeColor = UIColor.brown.cgColor
        shapeLayer.lineWidth = 3.0

        layer.addSublayer(shapeLayer)
    }
}


