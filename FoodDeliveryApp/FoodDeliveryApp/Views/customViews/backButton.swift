//
//  backButton.swift
//  FoodDeliveryApp
//
//  Created by Никита Павлов on 12.04.2025.
//

import UIKit
import SnapKit

final class BackButton: UIButton {
    
    init(target: Any?, action: Selector, backgroundColor: UIColor) {
        super.init(frame: .zero)
        setupBackButton(target: target, action: action, backgroundColor: backgroundColor)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupBackButton(target: Any?, action: Selector, backgroundColor: UIColor) {
        self.backgroundColor = backgroundColor
        layer.cornerRadius = 22.5
        imageView?.contentMode = .scaleAspectFit
        setImage(UIImage(systemName: "chevron.left"), for: .normal)
        tintColor = .label
        addTarget(target, action: action, for: .touchUpInside)
        
        snp.makeConstraints { make in
            make.height.width.equalTo(45)
        }
    }
}

    
    
