//
//  AllCategoriesCellCollectionViewCell.swift
//  FoodDeliveryApp
//
//  Created by Никита Павлов on 11.05.2025.
//


import UIKit

class AllCategoriesCell: UICollectionViewCell {
    static let reuseID = "AllCategoriesCell"
    let names = AllCategories.mockData()
    
    private lazy var view: UIView = {
        $0.layer.cornerRadius = 50
        $0.backgroundColor = .appGrey
        $0.addSubview(mainStack)
        return $0
    }(UIView())
    private lazy var mainStack: UIStackView = {
        $0.axis = .horizontal
        $0.distribution = .fill
        $0.spacing = 12
        $0.alignment = .center
        return $0
    }(UIStackView(arrangedSubviews: [grayView, mainLabel]))
    private lazy var grayView: UIView = {
        $0.backgroundColor = .gray
        $0.layer.cornerRadius = 22
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.heightAnchor.constraint(equalToConstant: 44).isActive = true
        $0.heightAnchor.constraint(equalToConstant: 44).isActive = true
        return $0
    }(UIView())
    private lazy var mainLabel: UILabel = {
        $0.font = .systemFont(ofSize: 14, weight: .medium)
        return $0
    }(UILabel())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        contentView.addSubview(view)

        view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        mainStack.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(8)
            make.top.bottom.equalToSuperview().inset(8)
        }
    }
    
    func configure (with category: AllCategories) {
        mainLabel.text = category.name
        
        if category.isSelected {
            view.backgroundColor = .appOrange
        } else {
            view.backgroundColor = .white
        }
    }
}
