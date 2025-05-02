//
//  CustomButton.swift
//  Calculator
//
//  Created by Никита Павлов on 02.05.2025.
//

import UIKit

final class CustomButton: UIButton {
    
    init(title: String, backgroundColor: UIColor, target: Any?, action: Selector) {
        super.init(frame: .zero)
        makeButton(title: title, backgroundColor: backgroundColor, target: target, action: action)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func makeButton(title: String, backgroundColor: UIColor, target: Any?, action: Selector) {
        self.setTitle(title, for: .normal)
        self.setTitleColor(.white, for: .normal)
        self.backgroundColor = backgroundColor
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.cornerRadius = 32
        
        self.addTarget(target, action: action, for: .touchUpInside)
    }
}
