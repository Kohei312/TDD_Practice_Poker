//
//  PokerCollectionViewControllersBuilder.swift
//  TDD_Practice_Poker
//
//  Created by kohei yoshida on 2020/10/12.
//

import Foundation
import UIKit

enum CollectionViewType{
    case cpuCardCollectionView
    case throwoutCardCollectionView
    case playerCardCollectionView
}


extension PokerViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDropDelegate,UICollectionViewDragDelegate{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        guard let pokerPresenter = self.pokerPresenter else {return 0}
        
        let playerhands = pokerPresenter.pokerInteractor.handStatus
        let cardDeck = playerhands.cardDeck
        
        switch collectionView{
        case playerCardCollectionView:
            return playerhands.myPlayerHand.cards.count
        case throwoutCardCollectionView:
            return cardDeck.appearedCards.count
        case cpuCardCollectionView:
            return playerhands.otherPlayerHand.cards.count
        default:
            return cardDeck.appearedCards.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        guard let pokerPresenter = self.pokerPresenter else {
            fatalError("CellDataSource is unKnown")
        }
        
        let playerhands = pokerPresenter.pokerInteractor.handStatus
        
        switch collectionView{
        case playerCardCollectionView:
            let cell = collectionView.dequeueReusableCell(with: PlayerCardCollectionViewCell.self, indexPath: indexPath)
            cell.suitLabel.text = playerhands.myPlayerHand.cards[indexPath.row].suit.rawValue
            cell.rankLabel.text = playerhands.myPlayerHand.cards[indexPath.row].rank.rawValue
            cell.setupPlayerCardCellColor(color: UIColor().cellColor(indexPath))
            return cell
        case throwoutCardCollectionView:
            let cell = collectionView.dequeueReusableCell(with: ThrowoutCardCollectionViewCell.self, indexPath: indexPath)
            cell.setupThrowoutCardCellColor(color: UIColor().cellColor(indexPath))
            return cell
        case cpuCardCollectionView:
            let cell = collectionView.dequeueReusableCell(with: CPUCardCollectionViewCell.self, indexPath: indexPath)
            cell.setupCPUCardCellColor(color: UIColor().cellColor(indexPath))
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(with: PlayerCardCollectionViewCell.self, indexPath: indexPath)
            cell.setupPlayerCardCellColor(color: UIColor().cellColor(indexPath))
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        
        let i = self.playerCardCollectionView.visibleCells(with: PlayerCardCollectionViewCell.self)[indexPath.row]
        switch i.cardChangeState{
        case .canChange:
            guard
                let id = self.pokerPresenter?.pokerInteractor.handStatus.myPlayerHand.cards[indexPath.item].id else {return []}
            let itemProvider = NSItemProvider(object: id.rawValue)
            self.removeCellHashValues.removeCellHashValues.append(i.hashValue)
            let dragItem = UIDragItem(itemProvider: itemProvider)
            dragItem.localObject = i.hashValue
            return [dragItem]
            
        case .cannotChange:
            return []
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, canHandle session: UIDropSession) -> Bool {
        
//        guard
//            let firstItem = session.items.first,
//            let object = firstItem.localObject,
//            let hashValue = object as? Int
//        else{ return false }
        guard
            let hashValue = removeCellHashValues.removeCellHashValues.last
        else{ return false }

        
        let cells = self.playerCardCollectionView.visibleCells(with: PlayerCardCollectionViewCell.self).filter({$0.hashValue == hashValue})
        if cells == []{
            return false
        } else {
            switch cells[0].cardChangeState{
            case .canChange:
                return true
            case .cannotChange:
                return false
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UICollectionViewDropProposal {
        
        var dropProposal = UICollectionViewDropProposal(operation: .cancel)
        if session.localDragSession != nil {
            // 内部からのドロップなら並び替えする
            switch collectionView{
            case playerCardCollectionView:
                dropProposal = UICollectionViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
            case throwoutCardCollectionView:
                
                guard
                    let hashValue = removeCellHashValues.removeCellHashValues.last
                else{ return dropProposal }
                
                let cells = self.playerCardCollectionView.visibleCells(with: PlayerCardCollectionViewCell.self).filter({$0.hashValue == hashValue})
                if cells != []{
                    if cells[0].cardChangeState == .canChange{
                        dropProposal = UICollectionViewDropProposal(operation: .copy,
                                                                    intent:.insertAtDestinationIndexPath)
                    } else {
                        dropProposal = UICollectionViewDropProposal(operation: .cancel)
                    }
                }
                
            default:break
            }
            
        } else {
            // 外部からのドロップならキャンセルする
            dropProposal = UICollectionViewDropProposal(operation: .cancel)
            
        }
        return dropProposal
    }
    
    // ここをPresenterと調整する
    func collectionView(_ collectionView: UICollectionView, performDropWith coordinator: UICollectionViewDropCoordinator) {
        
        switch coordinator.proposal.operation {
        
        // MARK:- カードを並べ替える（交換なし）
        case .move:
            guard
                let destinationIndexPath = coordinator.destinationIndexPath,
                let sourceIndexPath = coordinator.items.first?.sourceIndexPath,
                let sourceDragItem = coordinator.items.first?.dragItem
            else { return }
            
            //             データソースを更新する
            self.pokerPresenter?.changeCardIndex(playerType:.me,willMoveIndexPath:sourceIndexPath,willReplaceIndexPath:destinationIndexPath)
            
            self.playerCardCollectionView.performBatchUpdates({
                self.playerCardCollectionView.deleteItems(at: [sourceIndexPath])
                self.playerCardCollectionView.insertItems(at: [destinationIndexPath])
                coordinator.drop(sourceDragItem, toItemAt: destinationIndexPath)
            }){ _ in
                self.updateCardUI(sourceIndexPath: sourceIndexPath, destinationIndexPath: destinationIndexPath)
            }
            
            
            
            self.removeCellHashValues.removeCellHashValues = []
            
        // MARK:- カードを交換する
        case .copy:
            
            guard
                let hashValue = self.removeCellHashValues.removeCellHashValues.last,
                let cell = self.playerCardCollectionView.visibleCells(with: PlayerCardCollectionViewCell.self).filter({$0.hashValue == hashValue}).last,
                let indexPath = self.playerCardCollectionView.indexPath(for: cell)
            else { return }
            
            
            self.pokerPresenter?.changeCard(playerType: .me, takeNumber: 1,willRemoveIndexPath: indexPath)
            
            
            if let itemCount = self.pokerPresenter?.pokerInteractor.handStatus.myPlayerHand.cards.count {
                
                self.playerCardCollectionView.performBatchUpdates({
                    self.playerCardCollectionView.deleteItems(at: [indexPath])
                    // Appendされた位置にあるデータにのっとって更新される
                    self.playerCardCollectionView.insertItems(at: [IndexPath(item:  itemCount - 1, section: 0)])
                }){_ in
                    let cell = self.playerCardCollectionView.visibleCells(with: PlayerCardCollectionViewCell.self)[IndexPath(item:  itemCount - 1, section: 0).item]
                    cell.cardChangeState = .cannotChange
                    // 変更後のカードは、すべて最も暗い色にする -> 視覚的に変更不可がわかるように
                }
            }
            
            if let cardCount = self.pokerPresenter?.pokerInteractor.handStatus.cardDeck.appearedCards.count{
                self.throwoutCardCollectionView.performBatchUpdates({
                    self.throwoutCardCollectionView.insertItems(at: [IndexPath(row:  cardCount - 1, section: 0)])
                })
            }
            
            
            self.removeCellHashValues.removeCellHashValues = []
            
        case .cancel, .forbidden:
            self.removeCellHashValues.removeCellHashValues = []
            return
        @unknown default:
            self.removeCellHashValues.removeCellHashValues = []
            fatalError()
        }
    }
    
    func updateCardUI(sourceIndexPath:IndexPath?, destinationIndexPath:IndexPath?){
        let cells = self.playerCardCollectionView.visibleCells(with: PlayerCardCollectionViewCell.self)
        //        if let destinationIndexPath = destinationIndexPath, let sourceIndexPath = sourceIndexPath{
        //
        //            if destinationIndexPath > sourceIndexPath{
        //
        //                for leftIndex in 1...destinationIndexPath.row {
        //                    self.playerCardCollectionView.reloadItems(at: [IndexPath(item: leftIndex, section: 0)])
        //                }
        //
        ////                for rightIndex in destinationIndexPath.row..<5 {
        ////                    self.playerCardCollectionView.reloadItems(at: [IndexPath(item: rightIndex, section: 0)])
        ////                }
        //
        //            } else if destinationIndexPath < sourceIndexPath{
        //
        ////                for leftIndex in 1..<destinationIndexPath.row {
        ////                    self.playerCardCollectionView.reloadItems(at: [IndexPath(item: leftIndex, section: 0)])
        ////                }
        //                for rightIndex in destinationIndexPath.row...4 {
        //                    self.playerCardCollectionView.reloadItems(at: [IndexPath(item: rightIndex, section: 0)])
        //                }
        //
        //            }
        //
        //        } else {
        for index in 0..<cells.count {
            self.playerCardCollectionView.reloadItems(at: [IndexPath(item: index, section: 0)])
        }
    }
}
