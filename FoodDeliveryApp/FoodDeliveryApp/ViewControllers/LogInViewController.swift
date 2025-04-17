//
//  LogInViewController.swift
//  FoodDeliveryApp
//
//  Created by Никита Павлов on 06.04.2025.
//

import UIKit
import SnapKit

class LogInViewController: UIViewController {
    
    private lazy var images = CustomImageView(customVectorName: "Vector")
    private lazy var mainLabels = MainLabels(title: "Log In", titleSize: 30, textColor: .white, subtitle: "Please sign in to your existing account", spacing: 3)
    private lazy var contentView = CustomContentView()
    private lazy var emailField = loginTextFieldView(name: "EMAIL", placeholder: "example@gmail.com")
    private lazy var passwordField = PasswordTextField(name: "PASSWORD", placeholder: "**********")
    private lazy var textFieldsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [emailField, passwordField])
        stackView.axis = .vertical
        stackView.spacing = 24
        stackView.distribution = .fillEqually
        return stackView
    }()
    private lazy var forgotButton: UIButton = {
        forgotButton = UIButton()
        forgotButton.setTitle("Forgot Password", for: .normal)
        forgotButton.setTitleColor(.appOrange, for: .normal)
        forgotButton.titleLabel?.font = .systemFont(ofSize: 14, weight: .regular)
        forgotButton.translatesAutoresizingMaskIntoConstraints = false
        forgotButton.addTarget(self, action: #selector(pressForgotButton), for: .touchUpInside)
        return forgotButton
    }()
    private lazy var rememberMeButton: UIButton = {
        rememberMeButton = UIButton(type: .system)
        rememberMeButton.setImage(UIImage(systemName: "square"), for: .normal)
        rememberMeButton.tintColor = .systemGray3
        rememberMeButton.translatesAutoresizingMaskIntoConstraints = false
        rememberMeButton.addTarget(nil, action: #selector(toggleCheckbox), for: .touchUpInside)
        return rememberMeButton
    }()
    private lazy var rememberMeLabel: UILabel = {
        rememberMeLabel = UILabel()
        rememberMeLabel.text = "Remember me"
        rememberMeLabel.textColor = .systemGray
        rememberMeLabel.font = UIFont.systemFont(ofSize: 16)
        rememberMeLabel.translatesAutoresizingMaskIntoConstraints = false
        return rememberMeLabel
    }()
    private lazy var checkboxStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [rememberMeButton, rememberMeLabel])
        stack.axis = .horizontal
        stack.spacing = 8
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    private var isChecked = false
    private lazy var loginButton = MainButton(textButton: "LOG IN", target: self, action: #selector(loginTupped))
    private lazy var signInLabel: UILabel = {
        signInLabel = UILabel()
        signInLabel.text = "Don’t have an account?"
        signInLabel.textColor = .appGrey
        signInLabel.font = UIFont.systemFont(ofSize: 16)
        signInLabel.translatesAutoresizingMaskIntoConstraints = false
        return signInLabel
    }()
    private lazy var signUpButton: UIButton = {
        signUpButton = UIButton()
        signUpButton.setTitle("SIGN UP", for: .normal)
        signUpButton.setTitleColor( .appOrange, for: .normal)
        signUpButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        signUpButton.addTarget(self, action: #selector(signUpTupped), for: .touchUpInside)
        return signUpButton
    }()
    private lazy var signInStack: UIStackView = {
        signInStack = UIStackView(arrangedSubviews: [signInLabel, signUpButton])
        signInStack.axis = .horizontal
        signInStack.spacing = 10
        signInStack.alignment = .center
        signInStack.translatesAutoresizingMaskIntoConstraints = false
        return signInStack
    }()
    private lazy var orLabel: UILabel = {
        orLabel = UILabel()
        orLabel.text = "Or"
        orLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        orLabel.textColor = .appGrey
        orLabel.translatesAutoresizingMaskIntoConstraints = false
        return orLabel
    }()
    private lazy var stack = UIStackView()
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .logInBackground
        
        setupUI()
        setupKeyboardObservers()
        setupKeyboardDismissGesture()
    }
    
    private func setupUI() {
        setupImage()
        setupLabels()
        setContentView()
        setTextFields()
        setupForgotButton()
        setupRememberMeLabel()
        setupLoginButton()
        setupSignInStack()
        setupOrLabel()
        setAuthBtns()
    }
    
    private func setupImage() {
        view.addSubview(images)
        
        images.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupLabels() {
        view.addSubview(mainLabels)

        mainLabels.snp.makeConstraints { make in
            make.top.lessThanOrEqualToSuperview().offset(screenHeight*120/812)
            make.leading.trailing.equalToSuperview().inset(screenWidth*24/375)
        }
    }
    
    private func setContentView() {
        view.addSubview(contentView)
        
        contentView.snp.makeConstraints { make in
            make.top.lessThanOrEqualTo(mainLabels.snp.bottom).offset(screenHeight*50/812)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    private func setTextFields() {
        contentView.addSubview(textFieldsStackView)
        
        textFieldsStackView.snp.makeConstraints { make in
            make.top.lessThanOrEqualToSuperview().offset(screenHeight*24/812)
            make.leading.trailing.equalToSuperview().inset(screenWidth*24/375)
        }
    }
    
    private func setupKeyboardObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func setupForgotButton() {
        contentView.addSubview(forgotButton)
        
        forgotButton.snp.makeConstraints { make in
            make.top.lessThanOrEqualTo(textFieldsStackView.snp.bottom).offset(screenHeight*25/812)
            make.trailing.equalTo(textFieldsStackView.snp.trailing)
        }
    }
    
    private func setupRememberMeLabel() {
        contentView.addSubview(checkboxStack)
        
        checkboxStack.snp.makeConstraints { make in
            make.centerY.equalTo(forgotButton.snp.centerY)
            make.leading.equalTo(textFieldsStackView)
        }
    }
    
    private func setupLoginButton() {
        contentView.addSubview(loginButton)
        
        loginButton.snp.makeConstraints { make in
            make.top.lessThanOrEqualTo(forgotButton.snp.bottom).offset(screenHeight*30/812)
            make.leading.trailing.equalToSuperview().inset(screenWidth*24/375)
        }
    }
    
    private func setupSignInStack(){
        contentView.addSubview(signInStack)
        
        signInStack.snp.makeConstraints { make in
            make.top.lessThanOrEqualTo(loginButton.snp.bottom).offset(screenHeight*38/812)
            make.centerX.equalToSuperview()
        }
    }
    
    private func setupOrLabel(){
        contentView.addSubview(orLabel)
        
        orLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.lessThanOrEqualTo(signInStack.snp.bottom).offset(screenHeight*27/812)
        }
    }
    
    private func setAuthBtns(){
        let authButtonsStack = getAuthBtns()
        contentView.addSubview(authButtonsStack)
        
        authButtonsStack.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.lessThanOrEqualTo(orLabel.snp.bottom).offset(screenHeight*15/812)
            make.bottom.equalTo(contentView.snp.bottom).inset(screenHeight*39/812)
        }
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
    
    private func getAuthBtn(icon: UIImage, size: CGFloat = 62) -> UIButton {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.heightAnchor.constraint(equalToConstant: size).isActive = true
        btn.widthAnchor.constraint(equalToConstant: size).isActive = true
        btn.layer.cornerRadius = size/2
        btn.setImage(icon.withRenderingMode(.alwaysOriginal), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFit
        return btn
    }
    
    deinit {
                        NotificationCenter.default.removeObserver(self)
                    }
    
    //Действие для убирания клавиатуры
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
    
    @objc private func pressForgotButton() {
        let forgotPasswordVC = ForgotPasswordViewController()
        navigationController?.pushViewController(forgotPasswordVC, animated: true)
    }
    
    @objc func toggleCheckbox() {
            isChecked.toggle()
            let imageName = isChecked ? "checkmark.square" : "square"
            rememberMeButton.setImage(UIImage(systemName: imageName), for: .normal)
        }
    
    @objc func loginTupped() {
        print("LoginTupped")
    }
    
    @objc func signUpTupped() {
        let signUpVC = SignUpViewController()
        navigationController?.pushViewController(signUpVC, animated: true)
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

    @objc private func hideKeyboard() {
        view.endEditing(true)
    }
}
