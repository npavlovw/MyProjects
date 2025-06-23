//
//  AlarmsSettingsViewController.swift
//  InspirationAlarm
//
//  Created by Никита Павлов on 23.06.2025.
//

import UIKit
import SnapKit

class AlarmsSettingsViewController: UIViewController {
    
    //MARK: -UI-Components
    private let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .time
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.setValue(UIColor.white, forKeyPath: "textColor")
        return datePicker
    }()
    
    //MARK: -Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setNavigationItem()
        setAppearance()
        setupConstraints()
    }
    
    //MARK: -Constraints
    private func setupConstraints() {
        view.addSubview(datePicker)
        
        datePicker.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.height.equalTo(200)
        }
    }
    
    //MARK: -Logics
    private func setNavigationItem() {
        title = "Настройки"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: "Отмена",
            style: .plain,
            target: self,
            action: #selector(cancel))
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
    
    @objc private func saveSettings() {
        dismiss(animated: true)
    }
    
    @objc private func cancel() {
        dismiss(animated: true)
    }
}
