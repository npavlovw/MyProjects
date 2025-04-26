//
//  ProfileDescription.swift
//  FoodDeliveryApp
//
//  Created by Никита Павлов on 27.04.2025.
//

import UIKit
import SnapKit

final class ProfileDescription: UIView {
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textAlignment = .left
        return label
    }()
    lazy var bioLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textAlignment = .left
        return label
    }()
    lazy var vStack: UIStackView = {
       let stackView = UIStackView(arrangedSubviews: [nameLabel, bioLabel])
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.alignment = .leading
        return stackView
    }()
    lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 50
        return imageView
    }()
    lazy var profileStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [profileImageView, vStack])
        stackView.axis = .horizontal
        stackView.spacing = 32
        stackView.alignment = .center
        return stackView
    }()
    
    init(nameLabel: String, bioLabel: String, image: UIImage, frame: CGRect = .zero) {
        super.init(frame: frame)
        setupProfileView(name: nameLabel, bio: bioLabel, image: image)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupProfileView(name: String, bio: String, image: UIImage) {
        nameLabel.text = name
        bioLabel.text = bio
        profileImageView.image = image
        
        addSubview(profileStackView)
        
        profileImageView.snp.makeConstraints { make in
            make.width.height.equalTo(100)
        }
        profileStackView.snp.makeConstraints { make in
            make.height.equalTo(100)
            make.edges.equalToSuperview()
        }
    }
}
