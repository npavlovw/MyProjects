//
//  ViewController.swift
//  myProject
//
//  Created by Никита Павлов on 28.01.2025.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var UIView: UIImageView!
    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var labelEnter: UILabel!
    
    private let correctLogin: String = "user"
    private let correctPassword: String = "12345"
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }


    @IBAction func didTap(_ sender: UIButton) {
        labelEnter.text = ""
        guard loginTextField.text == correctLogin,
              passwordTextField.text == correctPassword
        else {
            loginTextField.layer.borderWidth = 2.0
            loginTextField.layer.borderColor = UIColor.red.cgColor
            loginTextField.layer.cornerRadius = 5.0
            passwordTextField.layer.borderWidth = 2.0
            passwordTextField.layer.borderColor = UIColor.red.cgColor
            passwordTextField.layer.cornerRadius = 5.0
            print ("Incorrect login")
            labelEnter.text = "Incorrect login"
            return
        }
        loginTextField.layer.borderWidth = 2.0
        loginTextField.layer.borderColor = UIColor.green.cgColor
        loginTextField.layer.cornerRadius = 5.0
        passwordTextField.layer.borderWidth = 2.0
        passwordTextField.layer.borderColor = UIColor.green.cgColor
        passwordTextField.layer.cornerRadius = 5.0
        print ("Correct login")
        labelEnter.text = "Correct login"
        dismiss(animated: true)
    }
}

