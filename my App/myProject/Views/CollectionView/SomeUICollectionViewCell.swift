//
//  SomeUICollectionViewCell.swift
//  myProject
//
//  Created by Никита Павлов on 16.02.2025.
//

import UIKit

class SomeUICollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var likeImage: UIImageView!
    @IBOutlet weak var imageView: UIImageView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil // Сбрасываем изображение перед повторным использованием ячейки
    }
}
