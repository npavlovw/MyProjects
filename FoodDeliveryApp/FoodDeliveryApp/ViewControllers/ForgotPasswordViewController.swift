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
    lazy var labels = MainLabels(title: "Forgot Password", subtitle: "Please sign in to your existing account")
    lazy var contentView = customContentView()
    lazy var emailTextField = loginTextFieldView()
    lazy var button = MainButton(textButton: "Send Code", target: self, action: #selector(buttonTupped))

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
            make.top.equalToSuperview().inset(50)
            make.leading.equalToSuperview().inset(24)
        }
    }
    
    private func setupLabels(){
        view.addSubview(labels)
        
        labels.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(120)
            make.leading.trailing.equalToSuperview()
        }
    }
    
    private func setupContentView() {
        view.addSubview(contentView)
        
        contentView.snp.makeConstraints { make in
            make.top.equalTo(labels.snp.bottom).offset(48)
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.713)
        }
    }
    
    private func setupEmailTextField() {
        contentView.addSubview(emailTextField)
        
        emailTextField.snp.makeConstraints{ make in
            make.top.equalTo(contentView).offset(24)
            make.leading.trailing.equalTo(contentView).inset(24)
        }
    }
    
    private func setupButton(){
        contentView.addSubview(button)
        
        button.snp.makeConstraints { (make) in
            make.top.equalTo(emailTextField.snp.bottom).offset(30)
            make.leading.trailing.equalToSuperview().inset(24)
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
