//
//  ViewController.swift
//  UIKitTasks
//
//  Created by Никита Павлов on 29.03.2025.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var UILabel: UILabel!
    @IBOutlet weak var UIButton: UIButton!
    @IBOutlet weak var UIButtonSaveText: UIButton!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var UIImageView: UIImageView!
    @IBOutlet weak var UISwitch: UISwitch!
    @IBOutlet weak var toNextViewButton: UIButton!
    @IBOutlet weak var toLilacViewButton: UIButton!
    @IBOutlet weak var switchTextLabel: UILabel!
    var isButtonTapped: Bool = false
    var isTextSave: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UILabel.text = "Hello, World!"
        UIButton.setTitle("Change colour", for: .normal)
        UIButtonSaveText.setTitle("Save text", for: .normal)
        UIImageView.image = UIImage(named: "landscape_01")
        toNextViewButton.setTitle("go to gray view", for: .normal)
        toLilacViewButton.setTitle("go to lilac view", for: .normal)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
            view.addGestureRecognizer(tapGesture)
        switchTextLabel.text = "Show/hide text"
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }

    //Изменения цвета текста
    @IBAction func chengeColourLabel(_ sender: UIButton) {
        isButtonTapped.toggle()
        if isButtonTapped {
            UILabel.textColor = .red
        } else {
            UILabel.textColor = .black
        }
    }
    
    //Сохранение текста в textfirld
    @IBAction func saveText(_ sender: UIButton) {
        isTextSave.toggle()
        if isTextSave {
            UILabel.text = textField.text
        } else {
            UILabel.text = ""
        }
    }
    
    
    @IBAction func showText(_ sender: UISwitch) {
        if sender.isOn {
            UILabel.isHidden = false
        } else {
            UILabel.isHidden = true
        }
    }
}

