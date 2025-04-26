//
//  TopAlignedTextField.swift
//  FoodDeliveryApp
//
//  Created by Никита Павлов on 30.04.2025.
//

import UIKit

final class TopAlignedTextField: UITextField {
    
    let padding = UIEdgeInsets(top: 10, left: 8, bottom: 0, right: 8)

    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}

