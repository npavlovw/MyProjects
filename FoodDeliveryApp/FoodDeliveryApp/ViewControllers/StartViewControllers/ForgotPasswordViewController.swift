//
//  ForgotPasswordViewController.swift
//  FoodDeliveryApp
//
//  Created by Никита Павлов on 11.04.2025.
//

import UIKit
import SnapKit

class ForgotPasswordViewController: UIViewController, UIGestureRecognizerDelegate {
    
    //MARK: UI-components
    lazy var images = CustomImageView(customVectorName: "orangeVector")
    lazy var backButton = BackButton(target: self, action: #selector(backToLoginScreen), backgroundColor: .white)
    lazy var labels = MainLabels(title: "Forgot Password", titleSize: 30, textColor: .white, subtitle: "Please sign in to your existing account", spacing: 4)
    lazy var contentView = CustomContentView()
    lazy var emailTextField = TextFieldView(name: "EMAIL", placeholder: "example@gmail.com")
    lazy var button = MainButton(textButton: "Send Code", target: self, action: #selector(buttonTupped))
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height

    //MARK: Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .logInBackground
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        
        setupConstraints()
        setupCustomBackButton()
        setupKeyboardObservers()
        setupKeyboardDismissGesture()
    }
    
    private func setupConstraints() {
        view.addSubview(images)
        view.addSubview(labels)
        view.addSubview(contentView)
        contentView.addSubview(emailTextField)
        contentView.addSubview(button)
        
        images.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        labels.snp.makeConstraints { make in
            make.top.lessThanOrEqualToSuperview().offset(screenHeight*120/812)
            make.leading.trailing.equalToSuperview()
        }
        contentView.snp.makeConstraints { make in
            make.top.lessThanOrEqualTo(labels.snp.bottom).offset(screenHeight*50/812)
            make.leading.trailing.bottom.equalToSuperview()
        }
        emailTextField.snp.makeConstraints{ make in
            make.top.lessThanOrEqualToSuperview().offset(screenHeight*24/812)
            make.leading.trailing.equalToSuperview().inset(screenWidth*24/375)
        }
        button.snp.makeConstraints { (make) in
            make.top.lessThanOrEqualTo(emailTextField.snp.bottom).offset(screenHeight*24/812)
            make.leading.trailing.equalToSuperview().inset(screenWidth*24/375)
        }
    }
    
    private func setupCustomBackButton() {
        let backBarButton = UIBarButtonItem(customView: backButton)
        navigationItem.leftBarButtonItem = backBarButton
    }
    
    //MARK: Logics
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
        navigationController?.pushViewController(verificationVC, animated: true)
    }
        
    @objc private func backToLoginScreen() {
        navigationController?.popViewController(animated: true)
    }
    
    //MARK: Keyboard
    private func setupKeyboardObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func setupKeyboardDismissGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardHeight = keyboardFrame.cgRectValue.height
            view.frame.origin.y = -keyboardHeight / 5
        }
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        view.frame.origin.y = 0
    }
    
    @objc private func hideKeyboard() {
        view.endEditing(true)
    }
}
