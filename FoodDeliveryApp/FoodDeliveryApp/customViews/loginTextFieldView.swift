//
//  CustomTextFildView.swift
//  FoodDeliveryApp
//
//  Created by Никита Павлов on 10.04.2025.
//

import UIKit
import SnapKit

final class loginTextFieldView: UIView {
    
    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = ""
        titleLabel.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        titleLabel.textColor = UIColor(red: 50/255, green: 52/255, blue: 62/255, alpha: 1)
        return titleLabel
    }()
    lazy var textField: UITextField = {
        let textField = UITextField()
        textField.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        textField.textColor = .black
        textField.layer.cornerRadius = 10
        textField.borderStyle = .none
        textField.backgroundColor = UIColor(red: 240/255, green: 245/255, blue: 250/255, alpha: 1)
        return textField
    }()
    lazy var loginEmailStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [titleLabel, textField])
        stack.axis = .vertical
        stack.spacing = 8
        stack.alignment = .leading
        stack.distribution = .fill
        return stack
    }()
    
    init(name: String, placeholder: String) {
        super.init(frame: .zero)
        setupLoginTextField(name: name, placeholder: placeholder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLoginTextField(name: String, placeholder: String) {
        titleLabel.text = name
        textField.placeholder = placeholder
        textField.setLeftPaddingPoints(16)
        textField.setRightPaddingPoints(16)        
        addSubview(loginEmailStack)
        
        loginEmailStack.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        titleLabel.snp.makeConstraints { make in
            make.height.equalTo(16)
        }
        textField.snp.makeConstraints { make in
            make.height.equalTo(62)
            make.width.equalToSuperview()
        }
    }
}
