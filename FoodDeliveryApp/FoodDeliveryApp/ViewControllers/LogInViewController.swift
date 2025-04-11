//
//  LogInViewController.swift
//  FoodDeliveryApp
//
//  Created by Никита Павлов on 06.04.2025.
//

import UIKit
import SnapKit

class LogInViewController: UIViewController {
    
    lazy var imageViewEllipse: UIImageView = {
        let imageViewEllipse = UIImageView()
        imageViewEllipse.image = UIImage(named: "Ellipse")
        imageViewEllipse.translatesAutoresizingMaskIntoConstraints = false
        return imageViewEllipse
    }()
    lazy var imageViewVector: UIImageView = {
        let imageViewVector = UIImageView()
        imageViewVector.image = UIImage(named: "Vector")
        imageViewVector.translatesAutoresizingMaskIntoConstraints = false
        return imageViewVector
    }()
    lazy var mainLabels = MainLabels(title: "Log In", subtitle: "Please sign in to your existing account")
    lazy var contentView = customContentView()
    lazy var emailField = loginTextFieldView(title: "EMAIL", placeholder: "example@gmail.com")
    lazy var passwordLabel: UILabel = {
        passwordLabel = UILabel()
        passwordLabel.text = "PASSWORD"
        passwordLabel.textColor = .black
        passwordLabel.font = .systemFont(ofSize: 13, weight: .semibold)
        passwordLabel.translatesAutoresizingMaskIntoConstraints = false
        return passwordLabel
    }()
    lazy var passwordTextLabel: UILabel = {
        passwordTextLabel = UILabel()
        passwordTextLabel.backgroundColor = .emailBackground
        passwordTextLabel.layer.cornerRadius = 10
        passwordTextLabel.layer.masksToBounds = true
        passwordTextLabel.translatesAutoresizingMaskIntoConstraints = false
        return passwordTextLabel
    }()
    lazy var passwordTextField: UITextField = {
        passwordTextField = UITextField()
        passwordTextField.placeholder = "**********"
        passwordTextField.keyboardType = .emailAddress
        passwordTextField.isSecureTextEntry = true
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.rightView = eyeButton
        passwordTextField.rightViewMode = .always
        return passwordTextField
    }()
    lazy var eyeButton: UIButton = {
        eyeButton = UIButton()
        eyeButton.setImage(UIImage(systemName: "eye"), for: .normal)
        eyeButton.tintColor = .gray
        eyeButton.translatesAutoresizingMaskIntoConstraints = false
        eyeButton.addTarget(self, action: #selector(togglePasswordVisibility), for: .touchUpInside)
        return eyeButton
    }()
    lazy var forgotButton: UIButton = {
        forgotButton = UIButton()
        forgotButton.setTitle("Forgot Password", for: .normal)
        forgotButton.setTitleColor(.appOrange, for: .normal)
        forgotButton.titleLabel?.font = .systemFont(ofSize: 14, weight: .regular)
        forgotButton.translatesAutoresizingMaskIntoConstraints = false
        forgotButton.addTarget(self, action: #selector(pressForgotButton), for: .touchUpInside)
        return forgotButton
    }()
    lazy var rememberMeButton: UIButton = {
        rememberMeButton = UIButton(type: .system)
        rememberMeButton.setImage(UIImage(systemName: "square"), for: .normal)
        rememberMeButton.tintColor = .systemGray3
        rememberMeButton.translatesAutoresizingMaskIntoConstraints = false
        rememberMeButton.addTarget(nil, action: #selector(toggleCheckbox), for: .touchUpInside)
        return rememberMeButton
    }()
    lazy var rememberMeLabel: UILabel = {
        rememberMeLabel = UILabel()
        rememberMeLabel.text = "Remember me"
        rememberMeLabel.textColor = .systemGray
        rememberMeLabel.font = UIFont.systemFont(ofSize: 16)
        rememberMeLabel.translatesAutoresizingMaskIntoConstraints = false
        return rememberMeLabel
    }()
    lazy var checkboxStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [rememberMeButton, rememberMeLabel])
        stack.axis = .horizontal
        stack.spacing = 8
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    var isChecked = false
    lazy var loginButton: UIButton = {
        loginButton = UIButton()
        loginButton.backgroundColor = .appOrange
        loginButton.setTitle("Log In", for: .normal)
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.layer.cornerRadius = 12
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.addTarget(self, action: #selector(loginTupped), for: .touchUpInside)
        return loginButton
    }()
    lazy var signInLabel: UILabel = {
        signInLabel = UILabel()
        signInLabel.text = "Don’t have an account?"
        signInLabel.textColor = .appGrey
        signInLabel.font = UIFont.systemFont(ofSize: 16)
        signInLabel.translatesAutoresizingMaskIntoConstraints = false
        return signInLabel
    }()
    lazy var signInButton: UIButton = {
        signInButton = UIButton()
        signInButton.setTitle("SIGN UP", for: .normal)
        signInButton.setTitleColor( .appOrange, for: .normal)
        signInButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        signInButton.addTarget(self, action: #selector(signInTupped), for: .touchUpInside)
        return signInButton
    }()
    lazy var signInStack: UIStackView = {
        signInStack = UIStackView(arrangedSubviews: [signInLabel, signInButton])
        signInStack.axis = .horizontal
        signInStack.spacing = 10
        signInStack.alignment = .center
        signInStack.translatesAutoresizingMaskIntoConstraints = false
        return signInStack
    }()
    lazy var orLabel: UILabel = {
        orLabel = UILabel()
        orLabel.text = "Or"
        orLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        orLabel.textColor = .appGrey
        orLabel.translatesAutoresizingMaskIntoConstraints = false
        return orLabel
    }()
    lazy var stack = UIStackView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .logInBackground
        
        setupImage()
        setupLabels()
        setContentView()
        setEmail()
        setPassword()
        setupKeyboardObservers()
        setupForgotButton()
        setupRememberMeLabel()
        setupLoginButton()
        setupSignIn()
        setupOrLabel()
        setAuthBtns()
        setupKeyboardDismissGesture()

    }
    
    private func setupImage() {
        view.addSubview(imageViewEllipse)
        view.addSubview(imageViewVector)
        
        NSLayoutConstraint.activate([
            imageViewEllipse.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            imageViewEllipse.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            imageViewEllipse.widthAnchor.constraint(equalToConstant: 177),
            imageViewEllipse.heightAnchor.constraint(equalToConstant: 177),
            
            imageViewVector.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            imageViewVector.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            imageViewVector.widthAnchor.constraint(equalToConstant: 103),
            imageViewVector.heightAnchor.constraint(equalToConstant: 355)
        ])
    }
    
    private func setupLabels() {
        view.addSubview(mainLabels)
        
        mainLabels.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(120)
            make.leading.trailing.equalToSuperview()
        }
    }
    
    private func setContentView() {
        view.addSubview(contentView)
        
        contentView.snp.makeConstraints { make in
            make.top.equalTo(mainLabels.snp.bottom).offset(50)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    private func setEmail() {
        contentView.addSubview(emailField)
        
        emailField.snp.makeConstraints{ make in
            make.top.equalTo(contentView).offset(24)
            make.leading.trailing.equalTo(contentView).inset(24)
        }
    }
    
    private func setPassword() {
        contentView.addSubview(passwordLabel)
        contentView.addSubview(passwordTextLabel)
        contentView.addSubview(passwordTextField)
        passwordTextField.addSubview(eyeButton)
        
        
        NSLayoutConstraint.activate([
            passwordLabel.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 24),
            passwordLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            
            passwordTextLabel.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: 8),
            passwordTextLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            passwordTextLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            passwordTextLabel.heightAnchor.constraint(equalToConstant: 62),
            
            passwordTextField.topAnchor.constraint(equalTo: passwordTextLabel.topAnchor),
            passwordTextField.bottomAnchor.constraint(equalTo: passwordTextLabel.bottomAnchor),
            passwordTextField.leadingAnchor.constraint(equalTo: passwordTextLabel.leadingAnchor, constant: 8),
            passwordTextField.trailingAnchor.constraint(equalTo: passwordTextLabel.trailingAnchor, constant: -8),
            
            eyeButton.trailingAnchor.constraint(equalTo: passwordTextField.trailingAnchor, constant: -20),
            eyeButton.centerYAnchor.constraint(equalTo: passwordTextField.centerYAnchor),
            eyeButton.heightAnchor.constraint(equalToConstant: 14),
            eyeButton.widthAnchor.constraint(equalToConstant: 19)
        ])
        
    }
    
    private func setupKeyboardObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func setupForgotButton() {
        contentView.addSubview(forgotButton)
        
        NSLayoutConstraint.activate([
            forgotButton.topAnchor.constraint(equalTo: passwordTextLabel.bottomAnchor, constant: 25),
            forgotButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24)
        ])
    }
    
    private func setupRememberMeLabel() {
        view.addSubview(checkboxStack)
        
        NSLayoutConstraint.activate([
            checkboxStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            checkboxStack.centerYAnchor.constraint(equalTo: forgotButton.centerYAnchor),
            
            rememberMeButton.widthAnchor.constraint(equalToConstant: 20),
            rememberMeButton.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    private func setupLoginButton() {
        contentView.addSubview(loginButton)
        
        NSLayoutConstraint.activate([
            loginButton.topAnchor.constraint(equalTo: forgotButton.bottomAnchor, constant: 30),
            loginButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            loginButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            loginButton.heightAnchor.constraint(equalToConstant: 62)
        ])
    }
    
    private func setupSignIn(){
        contentView.addSubview(signInStack)
        
        NSLayoutConstraint.activate([
            signInStack.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            signInStack.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 36)
        ])
    }
    
    private func setupOrLabel(){
        contentView.addSubview(orLabel)
        
        NSLayoutConstraint.activate([
            orLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            orLabel.topAnchor.constraint(equalTo: signInStack.bottomAnchor, constant: 28)
        ])
    }
    
    private func setAuthBtns(){
        let authButtonsStack = getAuthBtns()
        authButtonsStack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(authButtonsStack)
        
        NSLayoutConstraint.activate([
            authButtonsStack.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            authButtonsStack.topAnchor.constraint(equalTo: orLabel.bottomAnchor, constant: 30),
            authButtonsStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -40)
        ])
    }
    
    private func getAuthBtns() -> UIStackView {
        let iconNames = [ "facebook", "twitter", "apple"]
        let icons = iconNames.compactMap { UIImage(named: $0) }
        
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        stack.alignment = .center
        stack.spacing = 32
        stack.translatesAutoresizingMaskIntoConstraints = false
        for (index, icon) in icons.enumerated() {
            let button = getAuthBtn(icon: icon)
            button.tag = index
            button.addTarget(self, action: #selector(authButtonTapped(_:)), for: .touchUpInside)
            stack.addArrangedSubview(button)
        }
        return stack
    }
    
    private func getAuthBtn(icon: UIImage, size: CGFloat = 62) ->UIButton {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.heightAnchor.constraint(equalToConstant: size).isActive = true
        btn.widthAnchor.constraint(equalToConstant: size).isActive = true
        btn.layer.cornerRadius = size/2
        btn.setImage(icon.withRenderingMode(.alwaysOriginal), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFit
        return btn
    }
    
    @objc func togglePasswordVisibility() {
        passwordTextField.isSecureTextEntry.toggle()
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
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc private func pressForgotButton() {
        print("Нажали кнопку \"Забыли пароль\"")
    }
    
    @objc func toggleCheckbox() {
            isChecked.toggle()
            let imageName = isChecked ? "checkmark.square" : "square"
            rememberMeButton.setImage(UIImage(systemName: imageName), for: .normal)
        }
    
    @objc func loginTupped() {
        print("Login tupped")
    }
    
    @objc func signInTupped() {
        print("SignIn tupped")
    }
    
    @objc private func authButtonTapped(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            print("Facebook tapped")
        case 1:
            print("Twitter tapped")
        case 2:
            print("Apple tapped")
        default:
            break
        }
    }
    
    //Действие для убирания клавиатуры
    private func setupKeyboardDismissGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }

    @objc private func hideKeyboard() {
        view.endEditing(true)
    }
}
