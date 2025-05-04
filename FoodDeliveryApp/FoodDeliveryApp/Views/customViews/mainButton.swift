//
//  mainButton.swift
//  FoodDeliveryApp
//
//  Created by Никита Павлов on 11.04.2025.
//

import UIKit
import SnapKit

final class MainButton: UIButton {
    
    init(textButton: String, target: Any?, action: Selector) {
        super.init(frame: .zero)
        setupMainButton(textButton: textButton, target: target, action: action)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupMainButton(textButton: String, target: Any?, action: Selector) {
        backgroundColor = .appOrange
        setTitle(textButton, for: .normal)
        titleLabel?.font = .systemFont(ofSize: 14, weight: .bold)
        setTitleColor(.white, for: .normal)
        layer.cornerRadius = 12
        addTarget(target, action: action, for: .touchUpInside)
        
        snp.makeConstraints { make in
            make.height.equalTo(62)
        }
    }
}
