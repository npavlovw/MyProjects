//
//  PersonalInfoViewController.swift
//  FoodDeliveryApp
//
//  Created by Никита Павлов on 27.04.2025.
//

import UIKit
import SnapKit

class PersonalInfoViewController: UIViewController, UIGestureRecognizerDelegate {
    
    //MARK: UI-Components
    private lazy var navBarView: UIView = {
        let navBarView = UIView()
        
        let backButton = BackButton(target: self, action: #selector(backToProfileScreen), backgroundColor: UIColor(named: "btnGray") ?? .gray)
        
        let titleLabel = UILabel()
        titleLabel.text = "Personal Info"
        titleLabel.textColor = .black
        titleLabel.font = .systemFont(ofSize: 17, weight: .regular)
                
        navBarView.addSubview(backButton)
        navBarView.addSubview(titleLabel)
        navBarView.addSubview(editBtn)
        
        navBarView.snp.makeConstraints { make in
            make.height.equalTo(45)
        }
        backButton.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        editBtn.snp.makeConstraints { make in
            make.width.equalTo(50)
            make.height.equalTo(30)
            make.trailing.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        titleLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        return navBarView
    }()
    private lazy var editBtn: UIButton = {
        let btn = UIButton()
        let underlineAttrString = NSAttributedString(
            string: "EDIT",
            attributes: [
                .underlineStyle: NSUnderlineStyle.single.rawValue,
                .font: UIFont.systemFont(ofSize: 14, weight: .regular),
                .foregroundColor: UIColor.appOrange
            ]
        )
        btn.setAttributedTitle(underlineAttrString, for: .normal)
        return btn
    }()
    private lazy var containerView: UIView = {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: (screenWidth * 272 / 375), height: 124)
        return view
    }()
    private lazy var profileDescription = ProfileDescription(nameLabel: "", bioLabel: "", image: UIImage(systemName: "person.circle.fill")!)
    private lazy var tableView: UITableView = {
        $0.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        $0.dataSource = self
        $0.delegate = self
        $0.backgroundColor = .white
        $0.separatorStyle = .none
        $0.layer.cornerRadius = 16
        $0.tableHeaderView = containerView
        return $0
    }(UITableView(frame: .zero, style: .insetGrouped))
    let sections = PersonalInfo.getAll()
    
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
        editBtn.addTarget(self, action: #selector(editTupped), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        profileDescription.nameLabel.text = UserDefaults.standard.string(forKey: "fullName")
        profileDescription.bioLabel.text = UserDefaults.standard.string(forKey: "bio")
    }
    
    //MARK: Constraints
    private func setupConstraints() {
        view.addSubview(navBarView)
        view.addSubview(containerView)
        containerView.addSubview(profileDescription)
        view.addSubview(tableView)
        
        navBarView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview().inset(24)
        }
        profileDescription.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().inset(24)
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(navBarView.snp.bottom).offset(24)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    @objc private func backToProfileScreen() {
        navigationController?.popViewController(animated: true)
    }
    @objc private func editTupped() {
        let editProfileVC = EditProfileViewController()
        navigationController?.pushViewController(editProfileVC, animated: true)
    }

}

//MARK: UITableViewDataSource UITableViewDelegate
extension PersonalInfoViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.backgroundColor = UIColor(red: 246/255, green: 248/255, blue: 250/255, alpha: 1)
        var config = cell.defaultContentConfiguration()
        config.text = sections[indexPath.row].label
        config.secondaryText = sections[indexPath.row].subLabel
        config.image = UIImage(named: sections[indexPath.row].icon)
        cell.contentConfiguration = config
        cell.accessoryType = .disclosureIndicator
        return cell
    }
}

extension PersonalInfoViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
