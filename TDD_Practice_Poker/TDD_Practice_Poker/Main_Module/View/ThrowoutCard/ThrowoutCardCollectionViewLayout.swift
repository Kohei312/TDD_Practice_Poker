//
//  ThrowoutCardCollectionViewLayout.swift
//  TDD_Practice_Poker
//
//  Created by kohei yoshida on 2020/10/12.
//

import Foundation
import UIKit

class ThrowOutCardsCollectionViewLayout:UICollectionViewLayout,RandomNumberProtocol{
    
    private var property = ThrowoutCardCollectionVewLayoutProperty()
    
    private var contentBounds = CGRect.zero
    override var collectionViewContentSize: CGSize {
        
        return contentBounds.size
    }
    
    private var cachedAttributes:[UICollectionViewLayoutAttributes] = []
    
    // Tips:- コールされるタイミング　：　レイアウト初回作成時、レイアウト変更時、invalidateLayout()が呼ばれたとき
    override func prepare() {
        super.prepare()
        
        guard let cv = collectionView else { return }
        cv.contentSize = collectionViewContentSize
        
        //        property.center = CGPoint(x: cv.bounds.midX, y: cv.bounds.midY)
        property.center = CGPoint(x: cv.bounds.midX , y: cv.bounds.midY)
        let shortAxisLength = min(cv.bounds.width, cv.bounds.height)
        // 正方形を作成 -> 円の直径をshortAxisLengthに設定
        property.itemSize = CGSize(width: shortAxisLength / 4, height: shortAxisLength / 2)
        property.radius = shortAxisLength
        property.numberOfItems = cv.numberOfItems(inSection: 0)
    }
    
    // MARK:- IndexPathに応じた,CollectionViewCellのレイアウトを決める
    // Tips:- UICollectionViewLayoutAttributesに、セルサイズや位置座標のプロパティがある
    // -> セルごとの配置をいじる
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
      
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            
            // MARK:- 2π * (item)番目のindexPath / collectionViewの1セクション内に格納されたアイテム数
            // 1/4円の長さ
            let circleLength = (.pi * 2 * CGFloat(indexPath.item)) / 3
            let angle = circleLength / CGFloat(property.numberOfItems)
            
            // indexPathが若いitemは、少し高さを出す.
            attributes.center = CGPoint(x: property.center.x , y: property.center.y )
            attributes.size = CGSize(width: property.itemSize.width, height: property.itemSize.height)
            attributes.transform = attributes.transform.rotated(by: 270 - (angle))
            
            return attributes
        
    }
    

    // MARK:- 表示範囲内にあるセルのLayoutAttributesを返す
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return (0 ..< property.numberOfItems).compactMap { item -> UICollectionViewLayoutAttributes? in
            self.layoutAttributesForItem(at: IndexPath(item: randomNumber(0..<5), section: 0))
        }
    }
}
