//
//  grayViewController.swift
//  UIKitTasks
//
//  Created by Никита Павлов on 30.03.2025.
//

import UIKit

class grayViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var saveText: UIButton!
    @IBOutlet weak var UIPickerView: UIPickerView!
    var colours: [String] = ["red", "green", "blue", "yellow", "black"]
    var styleOfText: [String] = ["bold", "italic", "system"]
    var size: [String] = ["15", "16", "17", "18", "19", "20"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = ""
        saveText.setTitle("Save text", for: .normal)
        UIPickerView.delegate = self
        UIPickerView.dataSource = self
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
            view.addGestureRecognizer(tapGesture)
    }
 
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func saveText(_ sender: UIButton) {
        label.text = textField.text
    }
}

extension grayViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return colours.count
        case 1:
            return styleOfText.count
        case 2:
            return size.count
        default:
            return 0;
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0:
            return colours[row]
        case 1:
            return styleOfText[row]
        case 2:
            return size[row]
        default:
            return nil
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            switch colours[row] {
            case "red":
                label.textColor = .red
            case "blue":
                label.textColor = .blue
            case "green":
                label.textColor = .green
            case "yellow":
                label.textColor = .yellow
            default:
                return label.textColor = .black
            }
        } else if component == 1 {
            switch styleOfText[row] {
            case "bold":
                label.font = .boldSystemFont(ofSize: 30)
            case "italic":
                label.font = .italicSystemFont(ofSize: 30)
            default:
                label.font = .systemFont(ofSize: 30)
            }
        } else {
            switch size[row] {
            case "15":
                label.font = label.font.withSize(15)
            case "16":
                label.font = label.font.withSize(16)
            case "17":
                label.font = label.font.withSize(17)
            case "18":
                label.font = label.font.withSize(18)
            case "19":
                label.font = label.font.withSize(19)
            default:
                label.font = label.font.withSize(20)

            }
        }
        
    }
}
