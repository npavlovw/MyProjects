//
//  signUoViewController.swift
//  FoodDeliveryApp
//
//  Created by Никита Павлов on 16.04.2025.
//

import UIKit
import SnapKit

class SignUpViewController: UIViewController, UIGestureRecognizerDelegate {
    
    private lazy var images = CustomImageView(customVectorName: "orangeVector")
    private lazy var backButton = BackButton(target: self, action: #selector(backToLoginScreen))
    private lazy var mainLabels = MainLabels(title: "Sign Up", titleSize: 30, textColor: .white, subtitle: "Please sign up to get started", spacing: 16)
    private lazy var contentView = CustomContentView()
    private lazy var nameTextField = loginTextFieldView(name: "NAME", placeholder: "John doe")
    private lazy var emailTextField = loginTextFieldView(name: "EMAIL", placeholder: "example@gmail.com")
    private lazy var passwordTextField = PasswordTextField(name: "PASSWORD", placeholder: "**********")
    private lazy var reTypePasswordTextField = PasswordTextField(name: "RE-TYPE PASSWORD", placeholder: "**********")
    private lazy var textFieldsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [nameTextField, emailTextField, passwordTextField, reTypePasswordTextField])
        stackView.axis = .vertical
        stackView.spacing = 24
        return stackView
    }()
    private lazy var signUoButton = MainButton(textButton: "SIGN UP", target: self, action: #selector(signUpTupped))
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .logInBackground
        navigationController?.interactivePopGestureRecognizer?.delegate = self

        setupUI()
        setupKeyboardObservers()
        setupKeyboardDismissGesture()
    }
    
    private func setupUI() {
        setupImages()
        setupBackButton()
        setupMainLabels()
        setupContentView()
        setupTextFieldStackView()
        setupSignInButton()
    }
    
    private func setupBackButton() {
        let backBarButton = UIBarButtonItem(customView: backButton)
        navigationItem.leftBarButtonItem = backBarButton
    }
    
    private func setupImages() {
        view.addSubview(images)
        
        images.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupMainLabels() {
        view.addSubview(mainLabels)
        
        mainLabels.snp.makeConstraints { make in
            make.top.lessThanOrEqualToSuperview().offset(screenHeight*120/812)
            make.leading.trailing.equalToSuperview().inset(screenWidth*24/375)
        }
    }
    
    private func setupContentView() {
        view.addSubview(contentView)
        
        contentView.snp.makeConstraints { make in
            make.top.lessThanOrEqualTo(mainLabels.snp.bottom).offset(screenHeight*50/812)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    private func setupTextFieldStackView() {
        contentView.addSubview(textFieldsStackView)
        
        textFieldsStackView.snp.makeConstraints { make in
            make.top.lessThanOrEqualToSuperview().offset(screenHeight*24/812)
            make.leading.trailing.equalToSuperview().inset(screenWidth*24/375)
        }
    }
    
    private func setupSignInButton() {
        contentView.addSubview(signUoButton)
        
        signUoButton.snp.makeConstraints { make in
            make.top.lessThanOrEqualTo(textFieldsStackView.snp.bottom).offset(screenHeight*48/812)
            make.leading.trailing.equalToSuperview().inset(screenWidth*24/375)
        }
    }
    
    //Действие для убирания клавиатуры
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
    
    @objc private func backToLoginScreen() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func signUpTupped() {
        print("Sign Up Tupped")
    }
}
