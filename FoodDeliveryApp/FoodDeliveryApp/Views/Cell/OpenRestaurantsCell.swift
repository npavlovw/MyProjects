//
//  AllRestaurantsCell.swift
//  FoodDeliveryApp
//
//  Created by Никита Павлов on 01.06.2025.
//

import UIKit
import SnapKit

class OpenRestaurantsCell: UICollectionViewCell {
    static let reuseID = "OpenRestaurantsCell"
    
    private lazy var grayView: UIView = {
        $0.backgroundColor = UIColor(red: 152/255, green: 168/255, blue: 184/255, alpha: 1)
        $0.layer.cornerRadius = 5
        return $0
    }(UIView())
    private lazy var nameLabel: UILabel = {
        $0.font = .systemFont(ofSize: 20, weight: .bold)
        $0.numberOfLines = 1
        return $0
    }(UILabel())
    private lazy var foodList: UILabel = {
        $0.font = .systemFont(ofSize: 14, weight: .regular)
        $0.textColor = UIColor(red: 160/255, green: 165/255, blue: 186/255, alpha: 1)
        $0.numberOfLines = 1
        return $0
    }(UILabel())
    private lazy var nameStackView: UIStackView = {
        $0.axis = .vertical
        $0.spacing = 5
        $0.alignment = .leading
        return $0
    }(UIStackView(arrangedSubviews: [nameLabel, foodList]))
    
    private lazy var starImage: UIImageView = {
        $0.image = .star1
        $0.contentMode = .scaleAspectFit
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.heightAnchor.constraint(equalToConstant: 20).isActive = true
        $0.widthAnchor.constraint(equalToConstant: 20).isActive = true
        return $0
    }(UIImageView())
    private lazy var gradeLabel: UILabel = {
        $0.font = .systemFont(ofSize: 16, weight: .bold)
        return $0
    }(UILabel())
    private lazy var gradeStackView: UIStackView = {
        $0.axis = .horizontal
        $0.spacing = 4
        $0.alignment = .center
        return $0
    }(UIStackView(arrangedSubviews: [starImage, gradeLabel]))
    
    private lazy var carImage: UIImageView = {
        $0.image = .car1
        $0.contentMode = .scaleAspectFit
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.heightAnchor.constraint(equalToConstant: 20).isActive = true
        $0.widthAnchor.constraint(equalToConstant: 20).isActive = true
        return $0
    }(UIImageView())
    private lazy var deliveryLabel: UILabel = {
        $0.font = .systemFont(ofSize: 14, weight: .regular)
        return $0
    }(UILabel())
    private lazy var deliveryStackView: UIStackView = {
        $0.axis = .horizontal
        $0.spacing = 9
        $0.alignment = .center

        return $0
    }(UIStackView(arrangedSubviews: [carImage, deliveryLabel]))
    
    private lazy var clockImage: UIImageView = {
        $0.image = .clock
        $0.contentMode = .scaleAspectFit
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.heightAnchor.constraint(equalToConstant: 20).isActive = true
        $0.widthAnchor.constraint(equalToConstant: 20).isActive = true
        return $0
    }(UIImageView())
    private lazy var timeLabel: UILabel = {
        $0.font = .systemFont(ofSize: 14, weight: .regular)
        return $0
    }(UILabel())
    private lazy var timeStackView: UIStackView = {
        $0.axis = .horizontal
        $0.spacing = 9
        $0.alignment = .center
        return $0
    }(UIStackView(arrangedSubviews: [clockImage, timeLabel]))
    
    private lazy var infoStackView: UIStackView = {
        $0.axis = .horizontal
        $0.spacing = 24
        return $0
    }(UIStackView(arrangedSubviews: [gradeStackView, deliveryStackView, timeStackView]))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.layoutIfNeeded()
    }
    
    //MARK: -Constraints
    private func setupConstraints() {
        contentView.addSubview(grayView)
        contentView.addSubview(nameStackView)
        contentView.addSubview(infoStackView)

        grayView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(137)
            make.width.equalTo(UIScreen.main.bounds.width - 48)
        }
        nameStackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(grayView.snp.bottom).offset(8)
        }
        infoStackView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.equalTo(nameStackView.snp.bottom).offset(14)
            make.bottom.equalToSuperview()
        }
    }
    
    func configure(with category: AllRestaurants) {
        nameLabel.text = category.name
        
        foodList.text = category.food.joined(separator: " - ")
        
        gradeLabel.text = String(category.grade)
        deliveryLabel.text = category.deliver.rawValue
        timeLabel.text = category.time
        
        if category.isSelected {
            contentView.backgroundColor = UIColor(red: 1, green: 210/255, blue: 124/255, alpha: 1)
        } else {
            contentView.backgroundColor = .white
        }
    }
}
