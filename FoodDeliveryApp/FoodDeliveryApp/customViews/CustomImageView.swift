//
//  imageViewEllipse.swift
//  FoodDeliveryApp
//
//  Created by Никита Павлов on 12.04.2025.
//

import UIKit
import SnapKit

final class CustomImageView: UIView {
    
    private let ellipse = UIImageView()
    private let customVector = UIImageView()
    
    init(customVectorName: String) {
        super.init(frame: .zero)
        setupImageViews(customVectorName: customVectorName)

    }
    
    required init?(coder: NSCoder) {
            super.init(coder: coder)
        setupImageViews(customVectorName: nil)
    }
    
    private func setupImageViews(customVectorName: String?) {
        ellipse.image = UIImage(named: "Ellipse")
        addSubview(ellipse)

        if let VectorName = customVectorName {
            customVector.image = UIImage(named: VectorName)
        }
        addSubview(customVector)
        
        ellipse.snp.makeConstraints { make in
            make.top.leading.equalToSuperview()
            make.height.width.equalTo(177)
        }
        
        customVector.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview()
            make.height.equalTo(355)
            make.width.equalTo(103)
        }
    }
}
