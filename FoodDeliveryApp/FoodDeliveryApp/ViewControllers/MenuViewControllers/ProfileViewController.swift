//
//  MenuViewController.swift
//  FoodDeliveryApp
//
//  Created by Никита Павлов on 24.04.2025.
//

import UIKit
import SnapKit

class ProfileViewController: UIViewController, UIGestureRecognizerDelegate {
    
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

        navBarView.snp.makeConstraints { make in
            make.width.equalTo(327)
            make.height.equalTo(45)
        }
        backButton.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        moreButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        titleLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
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
    private lazy var tableView: UITableView = {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 16
        $0.separatorStyle = .none
        $0.dataSource = self
        $0.delegate = self
        $0.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return $0
    }(UITableView(frame: .zero, style: .insetGrouped))
    let sections = Profile.makeData()

    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height

    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        self.navigationItem.hidesBackButton = true
        
        
        setupConstraints()
       
    }
    
    //MARK: Constraints
    private func setupConstraints() {
        view.addSubview(navBarView)
        view.addSubview(profileStackView)
        view.addSubview(tableView)
        
        profileImageView.snp.makeConstraints { make in
            make.width.height.equalTo(100)
        }
        
        navBarView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(50)
            make.leading.trailing.equalToSuperview().inset(24)
        }
        profileStackView.snp.makeConstraints { make in
            make.width.equalTo(272)
            make.height.equalTo(100)
            make.top.equalTo(navBarView.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(24)
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(profileStackView.snp.bottom).offset(32)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().inset(24)
        }
    }
    
    //MARK: Logics
    @objc private func backToMenuScreen() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func moreButtonTupped() {
        print("More button tapped")
    }
}

extension ProfileViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.backgroundColor = UIColor(red: 246/255, green: 248/255, blue: 250/255, alpha: 1)
        let model = sections[indexPath.section][indexPath.row]
        var config = cell.defaultContentConfiguration()
        config.text = model.label
        config.image = UIImage(named: model.image)
        cell.contentConfiguration = config
        cell.accessoryType = .disclosureIndicator
        return cell
    }
}

extension ProfileViewController: UITableViewDelegate {
    
}

