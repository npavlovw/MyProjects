//
//  CustomTextFildView.swift
//  FoodDeliveryApp
//
//  Created by Никита Павлов on 10.04.2025.
//

import UIKit
import SnapKit

final class loginTextFieldView: UIView {
    
    private let titleLabel = UILabel()
    let textField = UITextField()
    
    init() {
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        titleLabel.text = "EMAIL"
        titleLabel.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        titleLabel.textColor = UIColor(red: 50/255, green: 52/255, blue: 62/255, alpha: 1)
        
        textField.placeholder = "example@gmail.com"
        textField.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        textField.textColor = .black
        textField.layer.cornerRadius = 10
        textField.borderStyle = .none
        textField.backgroundColor = UIColor(red: 240/255, green: 245/255, blue: 250/255, alpha: 1)
        textField.setLeftPaddingPoints(16)
        textField.setRightPaddingPoints(16)
        
        addSubview(titleLabel)
        addSubview(textField)
        
        titleLabel.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
        }
        
        textField.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(62)
        }
    }
    
    
}

extension UITextField {
    func setLeftPaddingPoints(_ amount: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.height))
        leftView = paddingView
        leftViewMode = .always
    }

    func setRightPaddingPoints(_ amount: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.height))
        rightView = paddingView
        rightViewMode = .always
    }
}
