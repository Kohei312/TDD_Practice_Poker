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


extension PokerViewController:UICollectionViewDelegate,UICollectionViewDataSource{
    
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
        
        switch collectionView{
        case playerCardCollectionView:
            let cell = collectionView.dequeueReusableCell(with: PlayerCardCollectionViewCell.self, indexPath: indexPath)
            guard let pokerPresenter = self.pokerPresenter else { fatalError("CellDataSource is unKnown") }
            
            let playerhands = pokerPresenter.pokerInteractor.handStatus
            cell.setupLabels(
                suit:playerhands.myPlayerHand.cards[indexPath.row].suit.rawValue,
                rank:playerhands.myPlayerHand.cards[indexPath.row].rank.rawValue)
            cell.setupPlayerCardCellColor(color: UIColor().cellColor(indexPath))
            if moveCardStatuses.cardStatuses != [:]{
                cell.setupCardChangeStatus(moveCardStatuses.cardStatuses[indexPath] ?? .canChange)
            }
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
}

extension PokerViewController:UICollectionViewDropDelegate,UICollectionViewDragDelegate{
    func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        
        let i = self.playerCardCollectionView.visibleCells(with: PlayerCardCollectionViewCell.self)[indexPath.row]
        
        guard
            let id = self.pokerPresenter?.pokerInteractor.handStatus.myPlayerHand.cards[indexPath.item].id else {return []}
        self.removeCellHashValues.removeCellHashValues.append(i.hashValue)
        let itemProvider = NSItemProvider(object: id.rawValue)
        let dragItem = UIDragItem(itemProvider: itemProvider)
        dragItem.localObject = i.hashValue
        return [dragItem]
    }
    
    func collectionView(_ collectionView: UICollectionView, canHandle session: UIDropSession) -> Bool {
        
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
                
                if cells != [] && cells[0].cardChangeState == .canChange{
                    dropProposal = UICollectionViewDropProposal(operation: .copy,
                                                                intent:.insertAtDestinationIndexPath)
                } else if cells != [] && cells[0].cardChangeState == .cannotChange{
                    dropProposal = UICollectionViewDropProposal(operation: .cancel)
                }
            
            default:break
            }
            
        } else {
            // 外部からのドロップならキャンセルする
            dropProposal = UICollectionViewDropProposal(operation: .cancel)
            
        }
        return dropProposal
    }
    
    func updateCollectionViewUI(_ collectionView:UICollectionView,deleteIndexPath:IndexPath?,insertIndexPath:IndexPath,sourceDragItem:UIDragItem?,coordinator: UICollectionViewDropCoordinator?){
        
        switch collectionView{
        case playerCardCollectionView:
            guard let deleteIndexPath = deleteIndexPath,
                  let coordinator = coordinator
            else { return }
            
            collectionView.performBatchUpdates({
                collectionView.deleteItems(at: [deleteIndexPath])
                collectionView.insertItems(at: [insertIndexPath])
                if let sourceDragItem = sourceDragItem{
                    coordinator.drop(sourceDragItem, toItemAt: insertIndexPath)
                }
            }){ _ in
                self.updatePlayerCardUI(insertIndexPath: insertIndexPath, operation: coordinator.proposal.operation)
            }
        case throwoutCardCollectionView:
            collectionView.performBatchUpdates({
                collectionView.insertItems(at: [insertIndexPath])
            })
        case cpuCardCollectionView:
            
            break
        default:
            fatalError()
        }
    }
    
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
            
            self.updateCollectionViewUI(playerCardCollectionView, deleteIndexPath: sourceIndexPath, insertIndexPath: destinationIndexPath, sourceDragItem: sourceDragItem, coordinator: coordinator)
 
        // MARK:- カードを交換する
        case .copy:
            
            guard
                let hashValue = self.removeCellHashValues.removeCellHashValues.last,
                let cell = self.playerCardCollectionView.visibleCells(with: PlayerCardCollectionViewCell.self).filter({$0.hashValue == hashValue}).last,
                let deleteIndexPath = self.playerCardCollectionView.indexPath(for: cell)
            else { return }
            
            self.pokerPresenter?.changeCard(playerType: .me, takeNumber: 1,willRemoveIndexPath: deleteIndexPath)
            
            if let itemCount = self.pokerPresenter?.pokerInteractor.handStatus.myPlayerHand.cards.count,
               let cardCount = self.pokerPresenter?.pokerInteractor.handStatus.cardDeck.appearedCards.count {
 
                let insertIndexPath = IndexPath(item:itemCount - 1,section:0)
                let throwoutIndexPath = IndexPath(row:  cardCount - 1, section: 0)
                
                self.updateCollectionViewUI(playerCardCollectionView, deleteIndexPath: deleteIndexPath, insertIndexPath: insertIndexPath, sourceDragItem: nil, coordinator: coordinator)
                self.updateCollectionViewUI(throwoutCardCollectionView, deleteIndexPath: nil, insertIndexPath: throwoutIndexPath, sourceDragItem: nil, coordinator: coordinator)
                
            }
        case .cancel, .forbidden:
            return
        @unknown default:
            self.removeCellHashValues.removeCellHashValues = []
            fatalError()
        }
        self.removeCellHashValues.removeCellHashValues = []
    }
    
    func updatePlayerCardUI(insertIndexPath:IndexPath,operation: UIDropOperation){
        
        let cells = self.playerCardCollectionView.visibleCells(with: PlayerCardCollectionViewCell.self)
        
        switch operation{
        case .move:
            let currentStates = cells.compactMap({$0.cardChangeState})
            let indexPaths = self.playerCardCollectionView.indexPathsForVisibleItems
            moveCardStatuses.cardStatuses = zip(indexPaths, currentStates).reduce(into: [IndexPath: ChangeCardState]()) { $0[$1.0] = $1.1 }
            
            for index in 0..<cells.count {
                self.playerCardCollectionView.reloadItems(at: [IndexPath(item: index, section: 0)])
                if cells[index].cardChangeState == .cannotChange {
                    cells[index].contentView.backgroundColor = UIColor().changedCellColor()
                }
            }
        case .copy:
            let cell = cells[insertIndexPath.row]
            cell.cardChangeState = .cannotChange
        // 変更後のカードは、すべて最も暗い色にする -> 視覚的に変更不可がわかるように
            cell.contentView.backgroundColor = UIColor().changedCellColor()
        case .cancel,.forbidden:
            break
        @unknown default:
            fatalError()
        }
    }
    
}
