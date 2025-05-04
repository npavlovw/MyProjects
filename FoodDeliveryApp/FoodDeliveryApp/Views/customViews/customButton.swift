//
//  customButton.swift
//  FoodDeliveryApp
//
//  Created by Никита Павлов on 24.04.2025.
//

import UIKit
import SnapKit

final class CustomButton: UIButton {
    
    init(target: Any?, action: Selector, backgroundColor: UIColor, image: UIImage) {
        super.init(frame: .zero)
        setupButton(target: target, action: action, backgroundColor: backgroundColor, image: image)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupButton(target: Any?, action: Selector, backgroundColor: UIColor, image: UIImage) {
        self.backgroundColor = backgroundColor
        layer.cornerRadius = 22.5
        imageView?.contentMode = .scaleAspectFit
        setImage(image, for: .normal)
        tintColor = .label
        addTarget(target, action: action, for: .touchUpInside)
        
        snp.makeConstraints { make in
            make.height.width.equalTo(45)
        }
    }
}
