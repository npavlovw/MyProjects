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
    lazy var mainLabels = MainLabels(title: "Verification", titleSize: 30, textColor: .white, subtitle: "We have sent a code to your email", spacing: 4)
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
    lazy var codeLabel: UILabel = {
        let codeLabel = UILabel()
        codeLabel.text = "CODE"
        codeLabel.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        codeLabel.textColor = .black
        return codeLabel
    }()
    private var timer: Timer?
    private var secondsLeft = 60
    lazy var resendCodeButton: UIButton = {
        let button = UIButton(type: .system)
        button.isEnabled = false
        button.setTitle("Reset", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return button
    }()
    lazy var resendLabel: UILabel = {
        let label = UILabel()
        label.text = "in 60 sec"
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .gray
        return label
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .logInBackground
        
        setupUI()
    }
    
    private func setupUI() {
        setupImages()
        setupBackButton()
        setupLabels()
        setupEmailCode()
        setupContentView()
        setupCodeLabel()
        setupResendCode()
        startTimer()
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
            make.top.equalTo(mainLabels.snp.bottom).offset(6)
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
    
    private func setupCodeLabel() {
        contentView.addSubview(codeLabel)
        
        codeLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(24)
        }
    }

    private func setupResendCode() {
        contentView.addSubview(resendLabel)
        contentView.addSubview(resendCodeButton)
        
        resendLabel.snp.makeConstraints { make in
            make.centerY.equalTo(codeLabel.snp.centerY)
            make.trailing.equalToSuperview().offset(-24)
        }
        resendCodeButton.snp.makeConstraints { make in
            make.centerY.equalTo(resendLabel.snp.centerY)
            make.trailing.equalTo(resendLabel.snp.leading).offset(-2)
        }
        
        resendCodeButton.addTarget(self, action: #selector(resendTapped), for: .touchUpInside)
    }
    
    private func startTimer() {
        timer?.invalidate()
        secondsLeft = 60
        resendLabel.text = "in \(secondsLeft) sec"
        
        UIView.performWithoutAnimation {
            let attributedTitle = NSAttributedString(
                string: "Resend",
                attributes: [
                    .font: UIFont.systemFont(ofSize: 14, weight: .regular),
                    .underlineStyle: 0
                ]
            )
            resendCodeButton.setAttributedTitle(attributedTitle, for: .normal)
            resendCodeButton.layoutIfNeeded()
        }
        resendCodeButton.isEnabled = false
        resendCodeButton.setTitleColor(.gray, for: .normal)
        updateButtonTitle()
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    private func updateButtonTitle() {
        resendLabel.text = "in \(secondsLeft) sec"
    }
    
    @objc private func updateTimer() {
        secondsLeft -= 1
        updateButtonTitle()
        
        if secondsLeft <= 0 {
            resendLabel.text = ""
            timer?.invalidate()
            UIView.performWithoutAnimation {
                let attributedTitle = NSAttributedString(
                    string: "Resend",
                    attributes: [
                        .font: UIFont.systemFont(ofSize: 14, weight: .bold),
                        .underlineStyle: NSUnderlineStyle.single.rawValue
                    ]
                )
                resendCodeButton.setAttributedTitle(attributedTitle, for: .normal)
                resendCodeButton.layoutIfNeeded()
            }
            resendCodeButton.isEnabled = true
            resendCodeButton.setTitleColor(.black, for: .normal)
        }
    }
    
    @objc private func backToLForgotPassword() {
        let forgotPasswordVC = ForgotPasswordViewController()
        forgotPasswordVC.modalPresentationStyle = .fullScreen
        present(forgotPasswordVC, animated: false)
    }
    
    @objc private func resendTapped() {
        print("Таймер запущен заново")
        startTimer()
    }
}
