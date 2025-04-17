//
//  VerificationViewController.swift
//  FoodDeliveryApp
//
//  Created by Никита Павлов on 12.04.2025.
//

import UIKit
import SnapKit

class VerificationViewController: UIViewController, UITextFieldDelegate, UIGestureRecognizerDelegate {
    
    private lazy var backButton = BackButton(target: self, action: #selector(backToForgotPassword))
    private lazy var images = CustomImageView(customVectorName: "orangeVector")
    private lazy var mainLabels = MainLabels(title: "Verification", titleSize: 30, textColor: .white, subtitle: "We have sent a code to your email", spacing: 4)
    var receivedText: String?
    private lazy var emailCode: UILabel = {
        let label = UILabel()
        label.text = receivedText
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    private lazy var contentView = CustomContentView()
    private lazy var codeLabel: UILabel = {
        let codeLabel = UILabel()
        codeLabel.text = "CODE"
        codeLabel.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        codeLabel.textColor = .black
        return codeLabel
    }()
    private var timer: Timer?
    private var secondsLeft = 60
    private lazy var resendCodeButton: UIButton = {
        let button = UIButton(type: .system)
        button.isEnabled = false
        button.setTitle("Reset", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return button
    }()
    private lazy var resendLabel: UILabel = {
        let label = UILabel()
        label.text = "in 60 sec"
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .gray
        return label
    }()
    private lazy var numbersTextFields: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 26
        stack.distribution = .fillEqually
        return stack
    }()
    private lazy var codeTextFields: [UITextField] = []
    private lazy var verifyButton = MainButton(textButton: "VERIFY", target: self, action: #selector(verifyButtonTupped))
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .logInBackground
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        
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
        setNumbersTextFields()
        setupVerifyButton()
        setupKeyboardObservers()
        setupKeyboardDismissGesture()
        startTimer()
    }
   
    private func setupImages() {
        view.addSubview(images)
        
        images.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupBackButton() {
        let backBarButton = UIBarButtonItem(customView: backButton)
        navigationItem.leftBarButtonItem = backBarButton
    }
    
    private func setupLabels(){
        view.addSubview(mainLabels)
        
        mainLabels.snp.makeConstraints { make in
            make.top.lessThanOrEqualToSuperview().offset(screenHeight*120/812)
            make.leading.trailing.equalToSuperview().inset(screenWidth*24/375)
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
            make.top.lessThanOrEqualTo(mainLabels.snp.bottom).offset(screenHeight*50/812)
            make.leading.trailing.bottom.equalToSuperview()
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
    
    private func setNumbersTextFields() {
        for i in 0..<4 {
            let textField = UITextField()
            textField.tag = i
            textField.textAlignment = .center
            textField.font = UIFont.systemFont(ofSize: 16, weight: .bold)
            textField.keyboardType = .numberPad
            textField.layer.cornerRadius = 10
            textField.clipsToBounds = true
            textField.backgroundColor = UIColor(red: 240/255, green: 245/255, blue: 250/255, alpha: 1)
            textField.delegate = self
            textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
            
            codeTextFields.append(textField)
            numbersTextFields.addArrangedSubview(textField)
        }
        
        contentView.addSubview(numbersTextFields)
        
        numbersTextFields.snp.makeConstraints { make in
            make.top.lessThanOrEqualTo(codeLabel.snp.bottom).offset(screenHeight*8/812)
            make.leading.trailing.equalToSuperview().inset(screenWidth*24/375)
            make.height.equalTo(screenHeight*62/812)
        }
    }
    
    private func setupVerifyButton() {
        contentView.addSubview(verifyButton)
        
        verifyButton.snp.makeConstraints { make in
            make.top.lessThanOrEqualTo(numbersTextFields.snp.bottom).offset(screenHeight*30/812)
            make.leading.trailing.equalToSuperview().inset(screenWidth*24/375)
        }
    }
    
    //Работа с клавиатурой
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
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        guard let text = textField.text else { return }
        
        // если введена цифра — переходим к следующему полю
        if text.count == 1 {
            let nextTag = textField.tag + 1
            if nextTag < codeTextFields.count {
                codeTextFields[nextTag].becomeFirstResponder()
            } else {
                textField.resignFirstResponder() // если последнее — убираем фокус
            }
        }
        // если удаление — возвращаемся назад
        else if text.count == 0 {
            let prevTag = textField.tag - 1
            if prevTag >= 0 {
                codeTextFields[prevTag].becomeFirstResponder()
            }
        }
        // ограничиваем ввод до 1 символа
        if text.count > 1 {
            textField.text = String(text.prefix(1))
        }
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
    
    @objc private func backToForgotPassword() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func resendTapped() {
        print("Таймер запущен заново")
        startTimer()
    }
    
    @objc private func verifyButtonTupped() {
        print("Verify button tupped")
    }
}
