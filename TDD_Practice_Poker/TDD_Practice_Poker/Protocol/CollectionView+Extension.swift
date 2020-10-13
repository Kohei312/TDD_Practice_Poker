//
//  CollectionView+Extension.swift
//  TDD_Practice_Poker
//
//  Created by kohei yoshida on 2020/10/12.
//
import Foundation
import UIKit

extension UICollectionView{
    
    func registerCell<T:UICollectionViewCell>(_ cell:T.Type){
        self.register(UINib(nibName: T.identifier, bundle: nil),forCellWithReuseIdentifier: T.identifier)
        self.showsHorizontalScrollIndicator = false
    }
    
    func dequeueReusableCell<T:UICollectionViewCell>(with cell:T.Type, indexPath:IndexPath)->T{
        return dequeueReusableCell(withReuseIdentifier: T.identifier, for: indexPath) as! T
        
    }
    
    func registerLayout(layout:UICollectionViewLayout){
        self.collectionViewLayout = layout
    }
    
    func cellForItem<T:UICollectionViewCell>(with cell:T.Type, indexPath:IndexPath)->T{
        return dequeueReusableCell(withReuseIdentifier: T.identifier, for: indexPath) as! T
        
    }
    
    func visibleCells<T:UICollectionViewCell>(with cell:T.Type)->[T]{
        return self.visibleCells as! [T]
        
    }
    
}

