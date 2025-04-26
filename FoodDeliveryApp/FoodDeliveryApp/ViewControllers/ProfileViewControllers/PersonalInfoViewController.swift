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
    private lazy var profileDescription = ProfileDescription(nameLabel: "", bioLabel: "", image: UIImage(systemName: "person.circle.fill")!)

    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        self.navigationItem.hidesBackButton = true
        self.navigationController?.navigationBar.isHidden = true
        
        makeConstraints()
        editBtn.addTarget(self, action: #selector(editTupped), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        profileDescription.nameLabel.text = UserDefaults.standard.string(forKey: "fullName")
        profileDescription.bioLabel.text = UserDefaults.standard.string(forKey: "bio")
    }
    
    //MARK: Constraints
    private func makeConstraints() {
        view.addSubview(navBarView)
        view.addSubview(profileDescription)
        
        navBarView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview().inset(24)
        }
        profileDescription.snp.makeConstraints { make in
            make.top.equalTo(navBarView.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(24)
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
