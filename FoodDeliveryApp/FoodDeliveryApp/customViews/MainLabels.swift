//
//  mainLabels.swift
//  FoodDeliveryApp
//
//  Created by Никита Павлов on 11.04.2025.
//

import UIKit
import SnapKit

final class MainLabels: UIView {
    
    private let titleLabel = UILabel()
    let subTitleLabel = UILabel()
    
    init(title: String, subtitle: String) {
        super.init(frame: .zero)
        setupMainLabels(title: title, subtitle: subtitle)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupMainLabels(title: String, subtitle: String) {
        titleLabel.text = title
        titleLabel.textColor = .white
        titleLabel.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        
        subTitleLabel.text = subtitle
        subTitleLabel.numberOfLines = 0
        subTitleLabel.textColor = .white
        subTitleLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        
        addSubview(titleLabel)
        addSubview(subTitleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
        }
        
        subTitleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
        }
    }
}
