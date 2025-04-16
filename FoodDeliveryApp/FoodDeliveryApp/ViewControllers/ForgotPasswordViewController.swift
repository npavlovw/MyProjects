//
//  ForgotPasswordViewController.swift
//  FoodDeliveryApp
//
//  Created by Никита Павлов on 11.04.2025.
//

import UIKit

class ForgotPasswordViewController: UIViewController {
    
    lazy var images = CustomImageView(customVectorName: "orangeVector")
    lazy var backButton = BackButton(target: self, action: #selector(backToLoginScreen))
    lazy var labels = MainLabels(title: "Forgot Password", titleSize: 30, textColor: .white, subtitle: "Please sign in to your existing account", spacing: 4)
    lazy var contentView = CustomContentView()
    lazy var emailTextField = loginTextFieldView(name: "EMAIL", placeholder: "example@gmail.com")
    lazy var button = MainButton(textButton: "Send Code", target: self, action: #selector(buttonTupped))
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .logInBackground
        
        setupImages()
        setupBackButton()
        setupLabels()
        setupContentView()
        setupEmailTextField()
        setupButton()
        setupKeyboardDismissGesture()
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
            make.top.lessThanOrEqualToSuperview().inset(screenHeight*50/812)
            make.leading.equalToSuperview().inset(screenWidth*24/375)
            make.height.equalTo(screenHeight*50/812)
            make.width.equalTo(screenHeight*50/812)
        }
    }
    
    private func setupLabels(){
        view.addSubview(labels)
        
        labels.snp.makeConstraints { make in
            make.top.lessThanOrEqualToSuperview().offset(screenHeight*120/812)
            make.leading.trailing.equalToSuperview()
        }
    }
    
    private func setupContentView() {
        view.addSubview(contentView)
        
        contentView.snp.makeConstraints { make in
            make.top.lessThanOrEqualTo(labels.snp.bottom).offset(screenHeight*50/812)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    private func setupEmailTextField() {
        contentView.addSubview(emailTextField)
        
        emailTextField.snp.makeConstraints{ make in
            make.top.lessThanOrEqualToSuperview().offset(screenHeight*24/812)
            make.leading.trailing.equalToSuperview().inset(screenWidth*24/375)
        }
    }
    
    private func setupButton(){
        contentView.addSubview(button)
        
        button.snp.makeConstraints { (make) in
            make.top.lessThanOrEqualTo(emailTextField.snp.bottom).offset(screenHeight*24/812)
            make.leading.trailing.equalToSuperview().inset(screenWidth*24/375)
        }
    }
    
    private func setupKeyboardDismissGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }

    @objc private func hideKeyboard() {
        view.endEditing(true)
    }
    
    @objc private func buttonTupped() {
        if let text = emailTextField.textField.text, text.isEmpty {
            let alert = UIAlertController(title: "Ошибка", message: "Введите email", preferredStyle: .alert)
                
                let okAction = UIAlertAction(title: "ОК", style: .default, handler: nil)
                alert.addAction(okAction)
                
                present(alert, animated: true, completion: nil)
            } else {
            goToNextScreen()
        }
        
    }
    
    private func goToNextScreen() {
        let verificationVC = VerificationViewController()
        verificationVC.receivedText = emailTextField.textField.text ?? ""
        verificationVC.modalPresentationStyle = .fullScreen
        present(verificationVC, animated: true)
    }
    
    @objc private func backToLoginScreen() {
        let loginVC = LogInViewController()
        loginVC.modalPresentationStyle = .fullScreen
        present(loginVC, animated: false)
    }

}
