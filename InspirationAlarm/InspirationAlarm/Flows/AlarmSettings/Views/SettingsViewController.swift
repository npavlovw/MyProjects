//
//  AlarmsSettingsViewController.swift
//  InspirationAlarm
//
//  Created by Никита Павлов on 23.06.2025.
//

import UIKit
import SnapKit

class SettingsViewController: UIViewController {
        
    var viewModel: SettingsViewModel
        
    init(viewModel: SettingsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: -UI-Components
    private lazy var cancelBtn: UIButton = {
        let button = UIButton()
        button.setTitle("Отмена", for: .normal)
        button.setTitleColor(.orange, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20)
        button.addTarget(self, action: #selector(cancelSettings), for: .touchUpInside)
        return button
    }()
    
    private lazy var saveSettingsBtn: UIButton = {
        let button = UIButton()
        button.setTitle("Сохранить", for: .normal)
        button.setTitleColor(.orange, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20)
        button.addTarget(self, action: #selector(saveSettings), for: .touchUpInside)
        return button
    }()
    
    private let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .time
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.setValue(UIColor.white, forKeyPath: "textColor")
        return datePicker
    }()
    
    private let nameTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .darkGray
        textField.layer.cornerRadius = 12
        textField.textColor = .white
        textField.attributedPlaceholder = NSAttributedString(
            string: "Введите название",
            attributes: [
                .foregroundColor: UIColor.lightGray
            ])
        textField.font = .systemFont(ofSize: 16, weight: .bold)
        let leftPadding = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 0))
        textField.leftView = leftPadding
        textField.leftViewMode = .always
        return textField
    }()
    
    //MARK: -Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setupConstraints()
        setupTapGesture()
    }
    
    //MARK: -Constraints
        private func setupConstraints() {
            view.addSubview(cancelBtn)
            view.addSubview(saveSettingsBtn)
            view.addSubview(datePicker)
            view.addSubview(nameTextField)

            cancelBtn.snp.makeConstraints {
                $0.top.equalToSuperview()
                $0.leading.equalToSuperview().offset(16)
            }
            saveSettingsBtn.snp.makeConstraints {
                $0.top.equalToSuperview()
                $0.trailing.equalToSuperview().inset(16)
            }
            datePicker.snp.makeConstraints {
                $0.leading.trailing.equalToSuperview()
                $0.top.equalTo(cancelBtn.snp.bottom)
                $0.height.equalTo(200)
            }
            nameTextField.snp.makeConstraints {
                $0.leading.trailing.equalToSuperview().inset(16)
                $0.top.equalTo(datePicker.snp.bottom).offset(24)
                $0.height.equalTo(44)
            }
        }
    
    //MARK: -Logics
    private func setupTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func saveSettings() {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        let timeString = formatter.string(from: datePicker.date)
        
        let name = nameTextField.text?.isEmpty == false ? nameTextField.text! : "Будильник"
        
        let newAlarm = Alarm(clock: timeString, name: name, isActive: true)
        
        viewModel.saveAlarm(alarm: newAlarm)
        
//        viewModel.sheduleAlertNotification(date: datePicker.date, title: name)
        
        viewModel.dismissPresentedScreen()
    }
    
//    private func saveAlarm(alarm: Alarm) {
//        var currentAlarms = fetchAlarms()
//        currentAlarms.append(alarm)
//        
//        if let data = try? JSONEncoder().encode(currentAlarms) {
//            UserDefaults.standard.set(data, forKey: "alarms")
//        }
//    }
//    
//    private func fetchAlarms() -> [Alarm] {
//        guard let data = UserDefaults.standard.data(forKey: "alarms"),
//            let alarms = try? JSONDecoder().decode([Alarm].self, from: data)
//        else {
//            return []
//        }
//        return alarms
//    }
    
    @objc private func cancelSettings() {
        viewModel.dismissPresentedScreen()
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
}
