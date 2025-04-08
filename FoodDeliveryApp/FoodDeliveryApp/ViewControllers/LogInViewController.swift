//
//  LogInViewController.swift
//  FoodDeliveryApp
//
//  Created by Никита Павлов on 06.04.2025.
//

import UIKit

class LogInViewController: UIViewController {
    
    //каждую вью сделать с помощью замыкания
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
    private let loginLabel = UILabel()
    private let loginSublabel = UILabel()
    private let contentView = UIView()
    private let emailLabel = UILabel()
    private let emailTextLabel = UILabel()
    private let emailTextField = UITextField()
    private let passwordLabel = UILabel()
    private let passwordTextLabel = UILabel()
    private let passwordTextField = UITextField()
    private let eyeButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .logInBackground
        
        setupImage()
        setupLabels()
        setContentView()
        setEmail()
        setPassword()
        setupKeyboardObservers()
        
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
        loginLabel.text = "Log In"
        loginLabel.textColor = .white
        loginLabel.font = .systemFont(ofSize: 30, weight: .bold)
        loginLabel.textAlignment = .center
        loginLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loginLabel)
        
        loginSublabel.text = "Please sign in to your existing account"
        loginSublabel.textColor = .white
        loginSublabel.font = .systemFont(ofSize: 16, weight: .regular)
        loginSublabel.textAlignment = .center
        loginSublabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loginSublabel)
        
        NSLayoutConstraint.activate([
            loginLabel.topAnchor.constraint(lessThanOrEqualTo: view.topAnchor, constant: 118),
            loginLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            loginSublabel.topAnchor.constraint(equalTo: loginLabel.bottomAnchor, constant: 3),
            loginSublabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func setContentView() {
        contentView.backgroundColor = .white
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.layer.cornerRadius = 24
        contentView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.addSubview(contentView)
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: loginSublabel.bottomAnchor, constant: 48),
            contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func setEmail() {
        emailLabel.text = "EMAIL"
        emailLabel.textColor = .black
        emailLabel.font = .systemFont(ofSize: 13, weight: .semibold)
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(emailLabel)
        
        emailTextLabel.backgroundColor = .emailBackground
        emailTextLabel.layer.cornerRadius = 10
        emailTextLabel.layer.masksToBounds = true
        emailTextLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(emailTextLabel)
        
        emailTextField.placeholder = "example@gmail.com"
        emailTextField.keyboardType = .emailAddress
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(emailTextField)
        
        NSLayoutConstraint.activate([
            emailLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24),
            emailLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            
            emailTextLabel.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 8),
            emailTextLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            emailTextLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            emailTextLabel.heightAnchor.constraint(equalToConstant: 62),
            
            emailTextField.topAnchor.constraint(equalTo: emailTextLabel.topAnchor),
            emailTextField.bottomAnchor.constraint(equalTo: emailTextLabel.bottomAnchor),
            emailTextField.leadingAnchor.constraint(equalTo: emailTextLabel.leadingAnchor, constant: 8),
            emailTextField.trailingAnchor.constraint(equalTo: emailTextLabel.trailingAnchor, constant: -8)
         ])
    }
    
    private func setPassword() {
        passwordLabel.text = "PASSWORD"
        passwordLabel.textColor = .black
        passwordLabel.font = .systemFont(ofSize: 13, weight: .semibold)
        passwordLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(passwordLabel)
        
        passwordTextLabel.backgroundColor = .emailBackground
        passwordTextLabel.layer.cornerRadius = 10
        passwordTextLabel.layer.masksToBounds = true
        passwordTextLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(passwordTextLabel)
        
        passwordTextField.placeholder = "**********"
        passwordTextField.keyboardType = .emailAddress
        passwordTextField.isSecureTextEntry = true
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(passwordTextField)
        passwordTextField.rightView = eyeButton
        passwordTextField.rightViewMode = .always
        
        eyeButton.setImage(UIImage(systemName: "eye"), for: .normal)
        eyeButton.tintColor = .gray
        eyeButton.translatesAutoresizingMaskIntoConstraints = false
        eyeButton.addTarget(self, action: #selector(togglePasswordVisibility), for: .touchUpInside)
        passwordTextField.addSubview(eyeButton)
        
        
        NSLayoutConstraint.activate([
            passwordLabel.topAnchor.constraint(equalTo: emailTextLabel.bottomAnchor, constant: 24),
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
}
