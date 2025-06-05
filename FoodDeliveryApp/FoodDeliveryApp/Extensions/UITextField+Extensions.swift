//
//  TextField+Extinsions.swift
//  FoodDeliveryApp
//
//  Created by Никита Павлов on 16.04.2025.
//

import UIKit

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
