//
//  Untitled.swift
//  FoodDeliveryApp
//
//  Created by Никита Павлов on 16.04.2025.
//

import UIKit
import SnapKit

final class PasswordTextField: UIView {
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        label.textColor = UIColor(red: 50/255, green: 52/255, blue: 62/255, alpha: 1)
        return label
    }()
    lazy var eyeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "eye"), for: .normal)
        button.tintColor = .gray
        return button
    }()
    lazy var textField: UITextField = {
        let textField = UITextField()
        textField.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        textField.textColor = .black
        textField.layer.cornerRadius = 10
        textField.isSecureTextEntry = true
        textField.borderStyle = .none
        textField.backgroundColor = UIColor(red: 240/255, green: 245/255, blue: 250/255, alpha: 1)
        return textField
    }()
    lazy var passwordStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [titleLabel, textField])
        stack.axis = .vertical
        stack.spacing = 8
        stack.alignment = .leading
        stack.distribution = .fill
        return stack
    }()
    
    init(name: String, placeholder: String) {
        super.init(frame: .zero)
        setupPasswordTextField(name: name, placeholder: placeholder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupPasswordTextField(name: String, placeholder: String) {
        titleLabel.text = name
        textField.placeholder = placeholder
        textField.setLeftPaddingPoints(16)
        textField.setRightPaddingPoints(16)
        eyeButton.addTarget(self, action: #selector(eyeButtonTupped) , for: .touchUpInside)

        addSubview(passwordStack)
        textField.addSubview(eyeButton)
        
        passwordStack.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        titleLabel.snp.makeConstraints { make in
            make.height.equalTo(16)
        }
        textField.snp.makeConstraints { make in
            make.height.equalTo(62)
            make.width.equalToSuperview()
        }
        eyeButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(20)
            make.width.equalTo(19)
            make.height.equalTo(14)
        }
    }
    
    @objc func eyeButtonTupped() {
        textField.isSecureTextEntry.toggle()
    }
}
