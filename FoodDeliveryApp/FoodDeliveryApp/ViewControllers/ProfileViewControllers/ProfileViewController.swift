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
        
        let moreButton = CustomButton(target: self, action: #selector(moreButtonTupped), backgroundColor: UIColor(named: "btnGray") ?? .gray, image: UIImage(named: "More")!)
        
        navBarView.addSubview(backButton)
        navBarView.addSubview(moreButton)
        navBarView.addSubview(titleLabel)

        navBarView.snp.makeConstraints { make in
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
            make.centerY.equalToSuperview()
            make.leading.equalTo(backButton.snp.trailing).offset(16)
        }
        return navBarView
    }()
    private lazy var containerView: UIView = {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: (screenWidth * 272 / 375), height: 124)
        return view
    }()
    private lazy var profileDescription = ProfileDescription(
        nameLabel: "",
        bioLabel: "",
        image: UIImage(systemName: "person.circle.fill")!,
    )
    private lazy var tableView: UITableView = {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 16
        $0.separatorStyle = .none
        $0.dataSource = self
        $0.delegate = self
        $0.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        $0.tableHeaderView = containerView
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
        self.navigationController?.navigationBar.isHidden = true

        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        profileDescription.nameLabel.text = UserDefaults.standard.string(forKey: "fullName")
        profileDescription.bioLabel.text = UserDefaults.standard.string(forKey: "bio")
    }
    
    //MARK: Constraints
    private func setupConstraints() {
        containerView.addSubview(profileDescription)
        view.addSubview(navBarView)
        view.addSubview(tableView)
       
        profileDescription.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().inset(24)
            make.trailing.top.equalToSuperview()
        }
        navBarView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview().inset(24)
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(navBarView.snp.bottom).offset(24)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    //MARK: Logics
    func didTapSaveButton(name: String, bio: String) {
        profileDescription.nameLabel.text = name
        profileDescription.bioLabel.text = bio
    }
    
    @objc private func backToMenuScreen() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func moreButtonTupped() {
        print("More button tapped")
    }
}

//MARK: UITableViewDataSource UITableViewDelegate

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

// TODO: - 
extension ProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 3 && indexPath.row == 0 {
            let alert = UIAlertController(title: "Внимание!", message: "Вы уверены, что хотите выйти?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))
            alert.addAction(UIAlertAction(title: "Выйти", style: .destructive, handler: { _ in
                UserDefaults.standard.removeObject(forKey: "hasLoggedIn")
                if let windowScene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene,
                   let window = windowScene.windows.first {
                    window.rootViewController = UINavigationController(rootViewController: LogInViewController())
                    UIView.transition(with: window,
                                      duration: 0.5,
                                      options: .transitionFlipFromRight,
                                      animations: nil,
                                      completion: nil)
                }
            }))
            present(alert, animated: true)
        }
        if indexPath.section == 0 && indexPath.row == 0 {
            let personalInfoVC = PersonalInfoViewController()
            navigationController?.pushViewController(personalInfoVC, animated: true)
        }
        if indexPath.section == 0 && indexPath.row == 1 {
            let adressesVC = AdressesViewController()
            navigationController?.pushViewController(adressesVC, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        100
    }
}


