//
//  ViewController.swift
//  Calculator
//
//  Created by Никита Павлов on 02.05.2025.
//

import UIKit
import Foundation

class CalculatorViewController: UIViewController {
    
    //MARK: - UI-components
    private lazy var mainLabel: UILabel = {
        $0.text = "Калькулятор"
        $0.textAlignment = .center
        $0.font = .systemFont(ofSize: 30, weight: .bold)
        $0.textColor = .white
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    var isResultDisplayed: Bool = false
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
    private lazy var commaButton = CustomButton(title: ".", backgroundColor: .darkGray, target: self, action: #selector(btnCommaTapped))
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
    }(UIStackView(arrangedSubviews: [buttonOne, buttonTwo, buttonThree, commaButton]))
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
    
    //MARK: - Lifecycle
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
    
    //MARK: - Logics
    private func appendToLabel(_ value: String) {
        guard let lastChar = label.text?.last else { return }

        // Если отображается результат и последний символ — не оператор, обнуляем поле
        if isResultDisplayed && !"+-*/".contains(lastChar) {
            label.text = "0"
            isResultDisplayed = false
        }

        // Сбрасываем флаг, если результат отображается и добавляется оператор
        if isResultDisplayed && "+-*/".contains(lastChar) {
            isResultDisplayed = false
        }

        // Заменяем 0 на значение или добавляем значение к существующему тексту
        if label.text == "0" {
            label.text = value
        } else {
            label.text? += value
        }
    }
    
    @objc private func btnOneTapped() { appendToLabel("1")}
    @objc private func btnTwoTapped() { appendToLabel("2")}
    @objc private func btnThreeTapped() { appendToLabel("3")}
    @objc private func btnFourTapped() { appendToLabel("4")}
    @objc private func btnFiveTapped() { appendToLabel("5")}
    @objc private func btnSixTapped() { appendToLabel("6")}
    @objc private func btnSevenTapped() { appendToLabel("7")}
    @objc private func btnEightTapped() { appendToLabel("8")}
    @objc private func btnNineTapped() { appendToLabel("9")}
    @objc private func btnZeroTapped() { appendToLabel("0")}
    
    private func appendToOperator(_ op: String) {
        if let lastChar = label.text?.last {
            if ["+", "-", "*", "/"].contains(lastChar) {
                label.text?.removeLast()
                label.text?.append(op)
            } else {
                label.text = (label.text ?? "") + op
            }
        }
    }
    @objc private func btnPlusTapped() { appendToOperator("+")}
    @objc private func btnMinusTapped() { appendToOperator("-")}
    @objc private func btnMultiplyTapped() { appendToOperator("*")}
    @objc private func btnDevideTapped() { appendToOperator("/")}
    
    
    @objc private func btnEqualsTapped() {
        guard let text = label.text, !text.isEmpty else { return }

        // Проверяем, чтобы последний символ не был оператором
        if let lastChar = text.trimmingCharacters(in: .whitespaces).last, "+-*/".contains(lastChar) {
            return
        }

        let expression = NSExpression(format: text)

        if let result = expression.expressionValue(with: nil, context: nil) as? NSNumber {
            let value = result.doubleValue
            label.text = value.truncatingRemainder(dividingBy: 1) == 0 ? String(Int(value)) : String(value)
        } else {
            label.text = "Ошибка"
        }

        isResultDisplayed = true
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
    @objc private func btnCommaTapped() {
        guard let lastChar = label.text?.last else { return }

        guard "0123456789".contains(lastChar) else { return }

        let components = label.text?.components(separatedBy: CharacterSet(charactersIn: "+-*/")) ?? []
        if let last = components.last, !last.contains(".") {
               label.text = (label.text ?? "") + "."
           }
    }
}
