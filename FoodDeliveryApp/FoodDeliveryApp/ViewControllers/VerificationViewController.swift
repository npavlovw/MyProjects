//
//  VerificationViewController.swift
//  FoodDeliveryApp
//
//  Created by Никита Павлов on 12.04.2025.
//

import UIKit
import SnapKit

class VerificationViewController: UIViewController {
    
    lazy var backButton = BackButton(target: self, action: #selector(backToLForgotPassword))
    lazy var images = CustomImageView(customVectorName: "orangeVector")
    lazy var mainLabels = MainLabels(title: "Verification", subtitle: "We have sent a code to your email")
    var receivedText: String?
    lazy var emailCode: UILabel = {
        let label = UILabel()
        label.text = receivedText
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    lazy var contentView = customContentView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .logInBackground
        
        setupImages()
        setupBackButton()
        setupLabels()
        setupEmailCode()
        setupContentView()

    }
   
    private func setupImages() {
        view.addSubview(images)
        
        images.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupBackButton() {
        view.addSubview(backButton)
        
        backButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(50)
            make.leading.equalToSuperview().inset(24)
        }
    }
    
    private func setupLabels() {
        view.addSubview(mainLabels)

        mainLabels.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(120)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(60)
        }
    }
    
    private func setupEmailCode() {
        view.addSubview(emailCode)
        
        emailCode.snp.makeConstraints { make in
            make.top.equalTo(mainLabels.snp.bottom).inset(4)
            make.centerX.equalToSuperview()
        }
    }
    
    private func setupContentView() {
        view.addSubview(contentView)
        
        contentView.snp.makeConstraints { make in
            make.top.equalTo(mainLabels.snp.bottom).offset(48)
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.713)
        }
    }
    
    @objc private func backToLForgotPassword() {
        let forgotPasswordVC = ForgotPasswordViewController()
        forgotPasswordVC.modalPresentationStyle = .fullScreen
        present(forgotPasswordVC, animated: false)
    }
    
}
