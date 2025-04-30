//
//  EditProfileViewController.swift
//  FoodDeliveryApp
//
//  Created by Никита Павлов on 28.04.2025.
//

import UIKit
import SnapKit

class EditProfileViewController: UIViewController, UIGestureRecognizerDelegate, UITextViewDelegate {
    
    
    //MARK: UI-Components
    private lazy var backButton = BackButton(target: self, action: #selector(backToPersonalInfoVC), backgroundColor: UIColor(named: "btnGray") ?? .gray)
    private lazy var titleLabel: UILabel = {
        $0.text = "Edit Profile"
        $0.font = .systemFont(ofSize: 17, weight: .regular)
       return $0
    }(UILabel())
    private lazy var titleStack: UIStackView = {
        $0.axis = .horizontal
        $0.spacing = 16
        $0.alignment = .center
        return $0
    }(UIStackView(arrangedSubviews: [backButton, titleLabel]))
    private lazy var scrollView = UIScrollView()
    private lazy var contentView = UIView()
    private lazy var imageView: UIImageView = {
        $0.image = UIImage(systemName: "person.circle.fill")
        $0.layer.cornerRadius = 65
        return $0
    }(UIImageView())
    private lazy var imageViewSettingsButton: UIButton = {
        $0.setImage(UIImage(systemName: "pencil"), for: .normal)
        $0.tintColor = .white
        $0.backgroundColor = .appOrange
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 20.5
        return $0
    }(UIButton())
    private lazy var fullNameTextField = TextFieldView(name: "Full Name", placeholder: "Vishal Khadok")
    private lazy var emailTextField = TextFieldView(name: "EMAIL", placeholder: "hello@halallab.co")
    private lazy var phoneNumberTextField = TextFieldView(name: "PHONE NUMBER", placeholder: "408-841-0926")
    private lazy var bioLabel: UILabel = {
        $0.text = "BIO"
        $0.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        $0.textColor = UIColor(red: 50/255, green: 52/255, blue: 62/255, alpha: 1)
        return $0
    }(UILabel())
    private let placeholderText = "I love fast food"
    private lazy var bioTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        textView.layer.cornerRadius = 10
        textView.backgroundColor = UIColor(red: 240/255, green: 245/255, blue: 250/255, alpha: 1)
        textView.textColor = .lightGray
        textView.text = placeholderText
        textView.textContainerInset = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        textView.delegate = self
        return textView
    }()
    private lazy var bioStack: UIStackView = {
        $0.axis = .vertical
        $0.spacing = 8
        $0.alignment = .leading
        $0.distribution = .fill
        return $0
    }(UIStackView(arrangedSubviews: [bioLabel, bioTextView]))
    private lazy var textFieldsStack: UIStackView = {
        $0.axis = .vertical
        $0.spacing = 24
        return $0
    }(UIStackView(arrangedSubviews: [fullNameTextField, emailTextField, phoneNumberTextField, bioStack]))
    private lazy var saveButton = MainButton(textButton: "Save", target: self, action: #selector(saveButtonTupped))

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        self.navigationItem.hidesBackButton = true
        self.navigationController?.navigationBar.isHidden = true
        
        makeConstraints()
        setupKeyboardObservers()
        setupKeyboardDismissGesture()
        imageViewSettingsButton.addTarget(self, action: #selector(imageViewSettingsButtonTupped), for: .touchUpInside)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fullNameTextField.textField.text = UserDefaults.standard.string(forKey: "fullName")
        emailTextField.textField.text = UserDefaults.standard.string(forKey: "email")
        phoneNumberTextField.textField.text = UserDefaults.standard.string(forKey: "phoneNumber")
        bioTextView.text = UserDefaults.standard.string(forKey: "bio")
        checkBioText(bioTextView)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        UserDefaults.standard.set(fullNameTextField.textField.text, forKey: "fullName")
        UserDefaults.standard.set(emailTextField.textField.text, forKey: "email")
        UserDefaults.standard.set(phoneNumberTextField.textField.text, forKey: "phoneNumber")
        UserDefaults.standard.set(bioTextView.text, forKey: "bio")
    }
    
    //MARK: Constraints
    private func makeConstraints() {
        view.addSubview(titleStack)
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(imageView)
        imageView.addSubview(imageViewSettingsButton)
        contentView.addSubview(textFieldsStack)
        contentView.addSubview(saveButton)
        
        titleStack.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.height.equalTo(45)
            make.leading.trailing.equalToSuperview().inset(24)
        }
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(titleStack.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
        }
        imageView.snp.makeConstraints { make in
            make.height.width.equalTo(130)
            make.top.equalToSuperview().offset(25)
            make.centerX.equalToSuperview()
        }
        imageViewSettingsButton.snp.makeConstraints { make in
            make.height.width.equalTo(41)
            make.trailing.bottom.equalToSuperview().inset(8)
        }
        bioTextView.snp.makeConstraints { make in
            make.height.equalTo(100)
            make.leading.trailing.equalToSuperview()
        }
        textFieldsStack.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(30)
            make.leading.trailing.equalToSuperview().inset(24)
        }
        saveButton.snp.makeConstraints { make in
            make.top.equalTo(textFieldsStack.snp.bottom).offset(32)
            make.leading.trailing.equalToSuperview().inset(24)
            make.bottom.equalToSuperview().offset(-30)
        }
    }
    
    //MARK: Logics
    @objc private func backToPersonalInfoVC() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func imageViewSettingsButtonTupped(){
        print("imageViewSettingsButtonTupped")
    }
    
    @objc private func saveButtonTupped(){
        navigationController?.popViewController(animated: true)
    }
    
    private func checkBioText(_ textView: UITextView){
        if textView.text == placeholderText {
            textView.textColor = .lightGray
        } else {
            textView.textColor = .black
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == placeholderText {
            textView.text = ""
            textView.textColor = .black
        }
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            textView.text = placeholderText
            textView.textColor = .lightGray
        }
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
