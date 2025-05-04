//
//  TopAlignedTextField.swift
//  FoodDeliveryApp
//
//  Created by Никита Павлов on 30.04.2025.
//

import UIKit

class TopAlignedTextField: UITextField {
    
    var textPadding = UIEdgeInsets(top: 12, left: 12, bottom: 74, right: 12)

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: textPadding)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: textPadding)
    }

    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: textPadding)
    }
}

