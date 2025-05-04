//
//  CustomTextFildView.swift
//  FoodDeliveryApp
//
//  Created by Никита Павлов on 10.04.2025.
//

import UIKit
import SnapKit

final class TextFieldView: UIView {
    
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
        textField.layer.cornerRadius = 10
        textField.borderStyle = .none
        textField.backgroundColor = UIColor(red: 240/255, green: 245/255, blue: 250/255, alpha: 1)
        return textField
    }()
    lazy var textFieldStack: UIStackView = {
        $0.axis = .vertical
        $0.spacing = 8
        $0.alignment = .leading
        $0.distribution = .fill
        return $0
    }(UIStackView(arrangedSubviews: [titleLabel, textField]))
    
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
        addSubview(textFieldStack)
        
        textFieldStack.snp.makeConstraints { make in
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
