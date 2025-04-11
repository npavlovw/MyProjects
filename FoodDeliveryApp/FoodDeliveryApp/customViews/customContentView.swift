//
//  contentView.swift
//  FoodDeliveryApp
//
//  Created by Никита Павлов on 11.04.2025.
//

import UIKit
import SnapKit

final class customContentView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupContentView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupContentView()
    }
    
    private func setupContentView() {
        backgroundColor = .white
        layer.cornerRadius = 24
        layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
}
