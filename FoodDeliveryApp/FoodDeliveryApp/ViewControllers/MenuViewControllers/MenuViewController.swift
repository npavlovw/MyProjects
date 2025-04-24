//
//  MenuViewController.swift
//  FoodDeliveryApp
//
//  Created by Никита Павлов on 24.04.2025.
//

import UIKit
import SnapKit

class MenuViewController: UIViewController, UIGestureRecognizerDelegate {
    
    //MARK: UI-components
    private lazy var navBarView: UIView = {
        let navBarView = UIView()
        
        let backButton = BackButton(target: self, action: #selector(backToMenuScreen), backgroundColor: UIColor(named: "btnGray") ?? .gray)
        
        let titleLabel = UILabel()
        titleLabel.text = "Profile"
        titleLabel.textColor = .black
        titleLabel.font = .systemFont(ofSize: 17, weight: .regular)
        
        let moreButton = CustomButton(target: self, action: #selector(moreButtonTupped), backgroundColor: UIColor(named: "btnGray") ?? .gray, image: UIImage(named: "MoreIcon")!)
        
        navBarView.addSubview(backButton)
        navBarView.addSubview(moreButton)
        navBarView.addSubview(titleLabel)

        backButton.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        moreButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(backButton.snp.centerY)
            make.leading.equalTo(backButton.snp.trailing).offset(16)
            make.trailing.equalTo(moreButton.snp.leading).inset(16)
        }
        return navBarView
    }()
    var recievedNameLabel: String?
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = recievedNameLabel
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textAlignment = .left
        return label
    }()
    var recievedBioLabel: String?
    private lazy var bioLabel: UILabel = {
        let label = UILabel()
        label.text = recievedBioLabel
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textAlignment = .left
        return label
    }()
    private lazy var vStack: UIStackView = {
       let stackView = UIStackView(arrangedSubviews: [nameLabel, bioLabel])
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.alignment = .leading
        return stackView
    }()
    private lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(systemName: "person.circle.fill")
        imageView.layer.cornerRadius = 50
        return imageView
    }()
    private lazy var profileStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [profileImageView, vStack])
        stackView.axis = .horizontal
        stackView.spacing = 32
        stackView.alignment = .center
        return stackView
    }()

    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height

    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        
        setupNavBarView()
        setupConstraints()
        
        
    }
    
    //MARK: Constraints
    private func setupConstraints() {
        view.addSubview(profileStackView)
        
        
        navBarView.snp.makeConstraints { make in
            make.width.equalTo(screenWidth * 327 / 345)
            make.height.equalTo(screenHeight * 45 / 812)
        }
        profileImageView.snp.makeConstraints { make in
            make.width.height.equalTo(100)
        }
        profileStackView.snp.makeConstraints { make in
            make.width.equalTo(screenWidth * 272 / 345)
            make.height.equalTo(screenHeight * 100 / 812)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(screenHeight * 24 / 812)
            make.leading.equalToSuperview().offset(screenWidth * 24 / 345)
        }
        
    }
    
    //MARK: Logics
    
    private func setupNavBarView() {
        self.navigationItem.titleView = navBarView
        self.navigationItem.hidesBackButton = true
    }
    
    @objc private func backToMenuScreen() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func moreButtonTupped() {
        print("More button tapped")
    }
}
