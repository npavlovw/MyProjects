//
//  CollectionViewController.swift
//  myProject
//
//  Created by Никита Павлов on 16.02.2025.
//

import UIKit

class CollectionViewController: UIViewController {
   
    @IBOutlet weak var collectionView: UICollectionView!

    var imageNames = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "landscape_01"]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.dragInteractionEnabled = true
        collectionView.dragDelegate = self
        collectionView.dropDelegate = self
        }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.reloadData() // Обновляем данные в коллекции
        }
    }

extension CollectionViewController: UICollectionViewDragDelegate {
    func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: any UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        let itemProvider = NSItemProvider(object: "\(indexPath)" as NSString)
        let dragItem = UIDragItem(itemProvider: itemProvider)
        return [dragItem]
    }
    
    func collectionView(_ collectionView: UICollectionView, itemsForAddingTo session: any UIDragSession, at indexPath: IndexPath, point: CGPoint) -> [UIDragItem] {
        let itemProvider = NSItemProvider(object: "\(indexPath)" as NSString)
        let dragItem = UIDragItem(itemProvider: itemProvider)
        dragItem.localObject = imageNames[indexPath.row]
        return [dragItem]
    }
}

extension CollectionViewController: UICollectionViewDropDelegate {
    func collectionView(_ collectionView: UICollectionView, performDropWith coordinator: any UICollectionViewDropCoordinator) {
        guard let indexPath = coordinator.destinationIndexPath, coordinator.proposal.operation == .move
        else {return}
        reorderItem(coordinator: coordinator, destinationIndexPath: indexPath, collectionView: collectionView)
    }
    
    func collectionView(_ collectionView: UICollectionView, dropSessionDidUpdate session: any UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UICollectionViewDropProposal {
        return UICollectionViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
    }
    
    private func reorderItem(coordinator: UICollectionViewDropCoordinator, destinationIndexPath: IndexPath, collectionView: UICollectionView) {
        guard let item = coordinator.items.first,
              let sourceIndexPath = item.sourceIndexPath
        else {return}
        
        collectionView.performBatchUpdates({
            let movedItem = imageNames.remove(at: sourceIndexPath.item) // Удаляем старый элемент
            imageNames.insert(movedItem, at: destinationIndexPath.item) // Вставляем на новое место
            
            collectionView.deleteItems(at: [sourceIndexPath])//Удаляем ячейку, где был старый элемент
            collectionView.insertItems(at: [destinationIndexPath])//Создаем ячейку, куда будет помещен новый объект
        })
        coordinator.drop(item.dragItem, toItemAt: destinationIndexPath)
    }
}

    extension CollectionViewController: UICollectionViewDataSource {
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return imageNames.count
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SomeUICollectionViewCell", for: indexPath) as! SomeUICollectionViewCell
            cell.imageView.image = UIImage(named: imageNames[indexPath.item])
            return cell
        }
        
        // Обновление массива при перемещении элементов
        func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
            let movedImage = imageNames.remove(at: sourceIndexPath.item)
            imageNames.insert(movedImage, at: destinationIndexPath.item)
            }
    }
    
    extension CollectionViewController: UICollectionViewDelegate {
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let fullscreenVC = storyboard.instantiateViewController(withIdentifier: "FullscreenViewController") as? FullscreenViewController {
                fullscreenVC.selectedImage = UIImage(named: imageNames[indexPath.item])
                fullscreenVC.modalPresentationStyle = .fullScreen
                present(fullscreenVC, animated: true, completion: nil)
            }
        }
    }
