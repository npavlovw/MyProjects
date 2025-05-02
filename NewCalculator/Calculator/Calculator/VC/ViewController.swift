//
//  ViewController.swift
//  Calculator
//
//  Created by Никита Павлов on 02.05.2025.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: UI-components
    private lazy var mainLabel: UILabel = {
        $0.text = "Калькулятор"
        $0.textAlignment = .center
        $0.font = .systemFont(ofSize: 30, weight: .bold)
        $0.textColor = .white
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    private lazy var buttonOne = CustomButton(title: "1", backgroundColor: .darkGray , target: self, action: #selector(btnOneTapped))
    private lazy var buttonTwo = CustomButton(title: "2", backgroundColor: .darkGray , target: self, action: #selector(btnTwoTapped))
    private lazy var buttonThree = CustomButton(title: "3", backgroundColor: .darkGray , target: self, action: #selector(btnThreeTapped))
    private lazy var buttonFour = CustomButton(title: "4", backgroundColor: .darkGray , target: self, action: #selector(btnFourTapped))
    private lazy var buttonFive = CustomButton(title: "5", backgroundColor: .darkGray , target: self, action: #selector(btnFiveTapped))
    private lazy var buttonSix = CustomButton(title: "6", backgroundColor: .darkGray , target: self, action: #selector(btnSixTapped))
    private lazy var buttonSeven = CustomButton(title: "7", backgroundColor: .darkGray , target: self, action: #selector(btnSevenTapped))
    private lazy var buttonEight = CustomButton(title: "8", backgroundColor: .darkGray , target: self, action: #selector(btnEightTapped))
    private lazy var buttonNine = CustomButton(title: "9", backgroundColor: .darkGray , target: self, action: #selector(btnNineTapped))
    private lazy var buttonZero = CustomButton(title: "0", backgroundColor: .darkGray , target: self, action: #selector(btnZeroTapped))
    private lazy var buttonPlus = CustomButton(title: "+", backgroundColor: .darkGray , target: self, action: #selector(btnPlusTapped))
    private lazy var buttonMinus = CustomButton(title: "-", backgroundColor: .darkGray , target: self, action: #selector(btnMinusTapped))
    private lazy var buttonMultiply = CustomButton(title: "*", backgroundColor: .darkGray , target: self, action: #selector(btnMultiplyTapped))
    private lazy var buttonDevide = CustomButton(title: "/", backgroundColor: .darkGray , target: self, action: #selector(btnDevideTapped))
    private lazy var buttonEquals = CustomButton(title: "=", backgroundColor: .darkGray , target: self, action: #selector(btnEqualsTapped))
    private lazy var ACButton = CustomButton(title: "AC", backgroundColor: .darkGray , target: self, action: #selector(btnACTapped))
    private lazy var deleteButton = CustomButton(title: "DEL", backgroundColor: .darkGray , target: self, action: #selector(btnDeleteTapped))
    private lazy var emptyView: UIView = {
        $0.backgroundColor = .clear
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIView())
    private lazy var emptyView2: UIView = {
        $0.backgroundColor = .clear
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIView())
    private lazy var emptyView3: UIView = {
        $0.backgroundColor = .clear
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIView())
    private lazy var deleteZeroStack: UIStackView = {
        $0.axis = .horizontal
        $0.spacing = 8
        $0.distribution = .fillEqually
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIStackView(arrangedSubviews: [ACButton, deleteButton, buttonZero, buttonEquals]))
    private lazy var oneTwoThreStack: UIStackView = {
        $0.axis = .horizontal
        $0.spacing = 8
        $0.distribution = .fillEqually
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIStackView(arrangedSubviews: [buttonOne, buttonTwo, buttonThree, emptyView3]))
    private lazy var fourFiveSixStack: UIStackView = {
        $0.axis = .horizontal
        $0.spacing = 8
        $0.distribution = .fillEqually
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIStackView(arrangedSubviews: [buttonFour, buttonFive, buttonSix, emptyView]))
    private lazy var sevenEightNineStack: UIStackView = {
        $0.axis = .horizontal
        $0.spacing = 8
        $0.distribution = .fillEqually
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIStackView(arrangedSubviews: [buttonSeven, buttonEight, buttonNine, emptyView2]))
    private lazy var plusMinusMultiplyDevideStack: UIStackView = {
        $0.axis = .horizontal
        $0.spacing = 8
        $0.distribution = .fillEqually
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIStackView(arrangedSubviews: [buttonPlus, buttonMinus, buttonMultiply, buttonDevide]))
    private lazy var mainStack: UIStackView = {
        $0.axis = .vertical
        $0.spacing = 8
        $0.distribution = .fillEqually
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIStackView(arrangedSubviews: [plusMinusMultiplyDevideStack, sevenEightNineStack, fourFiveSixStack, oneTwoThreStack, deleteZeroStack]))
    private lazy var label: UILabel = {
        $0.textColor = .white
        $0.text = "0"
        $0.textAlignment = .right
        $0.font = UIFont.systemFont(ofSize: 54, weight: .bold)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        setConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        label.text = UserDefaults.standard.string(forKey: "text")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        UserDefaults.standard.set(label.text, forKey: "text")
    }
    
    //MARK: Constraints
    private func setConstraints() {
        view.addSubview(mainLabel)
        view.addSubview(mainStack)
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            mainLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            mainLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            mainStack.heightAnchor.constraint(equalTo: plusMinusMultiplyDevideStack.widthAnchor),
            mainStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            mainStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            mainStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            
            label.trailingAnchor.constraint(equalTo: mainStack.trailingAnchor),
            label.bottomAnchor.constraint(equalTo: mainStack.topAnchor, constant: -12)
        ])
    }
    //MARK: Logics
    @objc private func btnOneTapped() {
        if label.text == "0" {
            label.text = "1"
        } else {
            label.text = (label.text ?? "") + "1"
        }
    }
    @objc private func btnTwoTapped() {
        if label.text == "0" {
            label.text = "2"
        } else {
            label.text = (label.text ?? "") + "2"
        }
    }
    @objc private func btnThreeTapped() {
        if label.text == "0" {
            label.text = "3"
        } else {
            label.text = (label.text ?? "") + "3"
        }
    }
    @objc private func btnFourTapped() {
        if label.text == "0" {
            label.text = "4"
        } else {
            label.text = (label.text ?? "") + "4"
        }
    }
    @objc private func btnFiveTapped() {
        if label.text == "0" {
            label.text = "5"
        } else {
            label.text = (label.text ?? "") + "5"
        }
    }
    @objc private func btnSixTapped() {
        if label.text == "0" {
            label.text = "6"
        } else {
            label.text = (label.text ?? "") + "6"
        }
    }
    @objc private func btnSevenTapped() {
        if label.text == "0" {
            label.text = "7"
        } else {
            label.text = (label.text ?? "") + "7"
        }
    }
    @objc private func btnEightTapped() {
        if label.text == "0" {
            label.text = "8"
        } else {
            label.text = (label.text ?? "") + "8"
        }
    }
    @objc private func btnNineTapped() {
        if label.text == "0" {
            label.text = "9"
        } else {
            label.text = (label.text ?? "") + "9"
        }
    }
    @objc private func btnZeroTapped() {
        if label.text == "0" {
            label.text = "0"
        } else {
            label.text = (label.text ?? "") + "0"
        }
    }
    @objc private func btnPlusTapped() {
        print("+")
    }
    @objc private func btnMinusTapped() {
        print("-")
    }
    @objc private func btnMultiplyTapped() {
        print("*")
    }
    @objc private func btnDevideTapped() {
        print("/")
    }
    @objc private func btnEqualsTapped() {
        print("=")
    }
    @objc private func btnACTapped() {
        label.text = "0"
    }
    @objc private func btnDeleteTapped() {
        guard label.text != "0" else { return }
        if let text = label.text, text.count > 1 {
            label.text = String(text.dropLast())
        } else {
            label.text = "0"
        }
    }
}
