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
    
    // ここをPresenterと調整する
    func collectionView(_ collectionView: UICollectionView, performDropWith coordinator: UICollectionViewDropCoordinator) {
                
        switch coordinator.proposal.operation {
        case .move:
            guard
                let destinationIndexPath = coordinator.destinationIndexPath,
                let sourceIndexPath = coordinator.items.first?.sourceIndexPath,
                let sourceDragItem = coordinator.items.first?.dragItem
            else { return }
            
//             データソースを更新する
            self.pokerPresenter?.pokerInteractor.changeCardIndex(playerType:.me,willMoveIndex:sourceIndexPath,willReplaceIndex:destinationIndexPath)

            self.playerCardCollectionView.performBatchUpdates({
                self.playerCardCollectionView.deleteItems(at: [sourceIndexPath])
                self.playerCardCollectionView.insertItems(at: [destinationIndexPath])
            })
            coordinator.drop(sourceDragItem, toItemAt: destinationIndexPath)
            
            let updateIndexes = playerCardCollectionView.indexPathsForVisibleItems
            self.playerCardCollectionView.reloadItems(at: updateIndexes)
     
        case .copy:
//            guard
//                // (0,0)
//                let destinationIndexPath = coordinator.destinationIndexPath,
//                // nil
//                let sourceIndexPath = coordinator.items.first?.sourceIndexPath
//            else { return }
            // データソースを更新する -> OK. もっと言えば、pokerPresenterでdrawCardをコールしたい
            self.pokerPresenter?.pokerInteractor.drawCard(playerType: .me, takeNumber: 1,willRemoveIndex: removedIndexPath)

                if let item = self.pokerPresenter?.pokerInteractor.handStatus.myPlayerHand.cards.count{
                    self.playerCardCollectionView.performBatchUpdates({
                        self.playerCardCollectionView.deleteItems(at: [removedIndexPath])
                        self.playerCardCollectionView.insertItems(at: [IndexPath(item: item - 1, section: 0)])
                     
                    })

                }
        
            if let itemitem = self.pokerPresenter?.pokerInteractor.handStatus.cardDeck.appearedCards.count{
                self.throwoutCardCollectionView.performBatchUpdates({
                    self.throwoutCardCollectionView.insertItems(at: [IndexPath(row:  itemitem - 1, section: 0)])
                })
            }

//            var updateIndexes = playerCardCollectionView.indexPathsForVisibleItems
////            updateIndexes.append(removedIndexPath)
//            self.playerCardCollectionView.reloadItems(at: updateIndexes)
 
        case .cancel, .forbidden:
            return
        @unknown default:
            fatalError()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        
        guard
            let pokerPresenter = self.pokerPresenter else {return []}
        let id = pokerPresenter.pokerInteractor.handStatus.myPlayerHand.cards[indexPath.item].id
        let itemProvider = NSItemProvider(object: id.rawValue)
        let dragItem = UIDragItem(itemProvider: itemProvider)
        removedIndexPath = indexPath
        return [dragItem]
    }
    
    func collectionView(_ collectionView: UICollectionView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UICollectionViewDropProposal {
        
        var dropProposal = UICollectionViewDropProposal(operation: .cancel)
        
        if session.localDragSession != nil {
            // 内部からのドロップなら並び替えする
            switch collectionView{
            case playerCardCollectionView:
                dropProposal = UICollectionViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
            case throwoutCardCollectionView:
                dropProposal = UICollectionViewDropProposal(operation: .copy, intent:.insertAtDestinationIndexPath)
            default:break
            }
            
        } else {
            // 外部からのドロップならキャンセルする
                dropProposal = UICollectionViewDropProposal(operation: .cancel)

        }
        return dropProposal
    }
    
}
