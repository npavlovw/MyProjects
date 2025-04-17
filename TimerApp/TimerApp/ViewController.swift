//
//  ViewController.swift
//  TimerApp
//
//  Created by Никита Павлов on 17.04.2025.
//

import UIKit
import SnapKit

final class TimerViewController: UIViewController {
    
    // MARK: - UI Components
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Timer Calculator"
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    
    private let datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .time
        picker.preferredDatePickerStyle = .wheels
        picker.locale = Locale.current
        picker.tintColor = .systemBlue
        return picker
    }()
    
    private let calculateButton: UIButton = {
        let button = UIButton()
        button.setTitle("Рассчитать", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 10
        return button
    }()
    
    private let resultLabel: UILabel = {
        let label = UILabel()
        label.text = "Здесь будет результат"
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.textColor = .darkGray
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.systemGroupedBackground
        setupLayout()
        calculateButton.addTarget(self, action: #selector(calculateTapped), for: .touchUpInside)
    }
    
    // MARK: - Layout
    private func setupLayout() {
        view.addSubview(titleLabel)
        view.addSubview(datePicker)
        view.addSubview(calculateButton)
        view.addSubview(resultLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(24)
            make.left.right.equalToSuperview().inset(20)
        }
        
        datePicker.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(32)
            make.left.right.equalToSuperview().inset(20)
        }
        
        calculateButton.snp.makeConstraints { make in
            make.top.equalTo(datePicker.snp.bottom).offset(32)
            make.centerX.equalToSuperview()
            make.width.equalTo(160)
            make.height.equalTo(48)
        }
        
        resultLabel.snp.makeConstraints { make in
            make.top.equalTo(calculateButton.snp.bottom).offset(32)
            make.left.right.equalToSuperview().inset(20)
        }
    }
    
    // MARK: - Logic
    @objc private func calculateTapped() {
        let calendar = Calendar.current
        let now = Date()
        let selectedTime = datePicker.date
        
        // Получаем компоненты времени
        let nowComponents = calendar.dateComponents([.hour, .minute], from: now)
        let targetComponents = calendar.dateComponents([.hour, .minute], from: selectedTime)
        
        guard
            let nowHour = nowComponents.hour,
            let nowMinute = nowComponents.minute,
            let targetHour = targetComponents.hour,
            let targetMinute = targetComponents.minute
        else {
            resultLabel.text = "Error calculating time."
            return
        }
        
        // Переводим текущее и целевое время в минуты
        let nowInMinutes = nowHour * 60 + nowMinute
        var targetInMinutes = targetHour * 60 + targetMinute
        
        // Если целевое время раньше текущего — значит, это на следующий день
        if targetInMinutes <= nowInMinutes {
            targetInMinutes += 24 * 60
        }
        
        let diffMinutes = targetInMinutes - nowInMinutes
        let hours = diffMinutes / 60
        let minutes = diffMinutes % 60
        
        resultLabel.text = "Установите таймер на \(hours)h \(minutes)m"
    }
}
