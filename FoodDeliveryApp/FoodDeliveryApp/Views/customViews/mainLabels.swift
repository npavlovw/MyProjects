//
//  mainLabels.swift
//  FoodDeliveryApp
//
//  Created by Никита Павлов on 11.04.2025.
//

import UIKit
import SnapKit

final class MainLabels: UIView {
    
    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = ""
        titleLabel.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        return titleLabel
    }()
    lazy var subTitleLabel: UILabel = {
        let subTitleLabel = UILabel()
        subTitleLabel.text = ""
        subTitleLabel.numberOfLines = 0
        subTitleLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        subTitleLabel.textAlignment = .center
        return subTitleLabel
    }()
    lazy var titleStack: UIStackView = {
        let titleStack = UIStackView(arrangedSubviews: [titleLabel, subTitleLabel])
        titleStack.axis = .vertical
        titleStack.spacing = 0
        titleStack.alignment = .center
        titleStack.distribution = .fill
        return titleStack
    }()
    
    init(title: String, titleSize: CGFloat, textColor: UIColor,subtitle: String, spacing: CGFloat) {
        super.init(frame: .zero)
        setupMainLabels(title: title, titleSize: titleSize, textColor: textColor, subtitle: subtitle, spacing: spacing)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupMainLabels(title: String, titleSize: CGFloat, textColor: UIColor, subtitle: String, spacing: CGFloat) {
        titleLabel.text = title
        titleLabel.font = UIFont.systemFont(ofSize: titleSize, weight: .bold)
        titleLabel.textColor = textColor
        subTitleLabel.text = subtitle
        subTitleLabel.textColor = textColor
        titleStack.spacing = spacing
        
        
        addSubview(titleStack)
        
        titleStack.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
