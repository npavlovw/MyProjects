//
//  AlarmsSettingsViewController.swift
//  InspirationAlarm
//
//  Created by Никита Павлов on 23.06.2025.
//

import UIKit
import SnapKit

class SettingsViewController: UIViewController {
    
    weak var coordinator: MainCoordinator?
    
    var viewModel: SettingsViewModel
    
    init(viewModel: SettingsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    //MARK: -UI-Components
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
        setNavigationItem()
        setAppearance()
        setupConstraints()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    //MARK: -Logics
    private func setNavigationItem() {
        title = "Настройки"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: "Отмена",
            style: .plain,
            target: self,
            action: #selector(cancelSettings))
        navigationItem.leftBarButtonItem?.tintColor = .systemOrange
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Сохранить",
            style: .done,
            target: self,
            action: #selector(saveSettings))
        navigationItem.rightBarButtonItem?.tintColor = .systemOrange
    }
    
    private func setAppearance() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .black
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    //MARK: -Constraints
    private func setupConstraints() {
        view.addSubview(datePicker)
        view.addSubview(nameTextField)
        
        datePicker.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.height.equalTo(200)
        }
        nameTextField.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.top.equalTo(datePicker.snp.bottom).offset(24)
            $0.height.equalTo(44)
        }
    }
    
    @objc private func saveSettings() {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        let timeString = formatter.string(from: datePicker.date)
        
        let name = nameTextField.text?.isEmpty == false ? nameTextField.text! : "Будильник"
        
        viewModel.saveSettingsTapped(clock: timeString, name: name)
        
        viewModel.sheduleAlertNotification(date: datePicker.date, title: name)
        
        coordinator?.dismissPresentedScreen()
    }
    
    @objc private func cancelSettings() {
        coordinator?.dismissPresentedScreen()
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
}
