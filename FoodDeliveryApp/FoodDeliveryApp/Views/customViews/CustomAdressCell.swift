//
//  CustomAdresesCell.swift
//  FoodDeliveryApp
//
//  Created by Никита Павлов on 01.05.2025.
//

import UIKit

class AdressCell: UITableViewCell {
    
    static let reuseID = "AdressCell"
    
    private var adressCellView: UIView = {
        $0.backgroundColor = UIColor(red: 240/255, green: 245/255, blue: 250/255, alpha: 1)
        $0.layer.cornerRadius = 16
        $0.clipsToBounds = true
        return $0
    }(UIView())
    private var image: UIImageView = {
        $0.contentMode = .scaleAspectFit
        $0.clipsToBounds = true
        return $0
    }(UIImageView())
    private var nameLabel: UILabel = {
        $0.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        return $0
    }(UILabel())
    private var cellDescription: UILabel = {
        $0.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        $0.numberOfLines = 0
        return $0
    }(UILabel())
    private var deleteIcon: UIButton = {
        $0.setImage(UIImage(systemName: "trash"), for: .normal)
        $0.tintColor = UIColor(red: 251/255, green: 109/255, blue: 58/255, alpha: 1)
        return $0
    }(UIButton(primaryAction: nil))
    private var editIcon: UIButton = {
        $0.setImage(UIImage(systemName: "square.and.pencil"), for: .normal)
        $0.tintColor = UIColor(red: 251/255, green: 109/255, blue: 58/255, alpha: 1)
        return $0
    }(UIButton(primaryAction: nil))
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        makeConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func makeConstraints() {
        contentView.addSubview(adressCellView)
        adressCellView.addSubview(image)
        adressCellView.addSubview(nameLabel)
        adressCellView.addSubview(cellDescription)
        adressCellView.addSubview(deleteIcon)
        adressCellView.addSubview(editIcon)
        
        adressCellView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(24)
            make.bottom.equalToSuperview().inset(20)
        }
        image.snp.makeConstraints { make in
            make.height.width.equalTo(48)
            make.top.leading.equalToSuperview().offset(16)
        }
        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalTo(image.snp.trailing).offset(14)
            make.trailing.equalTo(editIcon.snp.leading).inset(14)
        }
        cellDescription.snp.makeConstraints { make in
            make.leading.equalTo(nameLabel.snp.leading)
            make.top.equalTo(nameLabel.snp.bottom).offset(8)
            make.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(24)
        }
        deleteIcon.snp.makeConstraints { make in
            make.trailing.top.equalToSuperview().inset(15)
        }
        editIcon.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.trailing.equalTo(deleteIcon.snp.leading).inset(-20)
        }
    }
    
    func setupCell(adress: Adresses) {
        image.image = UIImage(named: adress.image)
        nameLabel.text = adress.name
        cellDescription.text = adress.description
    }
}
