//
//  SettingsViewModel.swift
//  InspirationAlarm
//
//  Created by Никита Павлов on 24.06.2025.
//

import UserNotifications

protocol SettingsViewModelDelegate: AnyObject {
    func didSaveAlarm(_ alarm: Alarm)
}

final class SettingsViewModel {
    
    weak var coordinator: MainCoordinator?
    
    weak var delegate: SettingsViewModelDelegate?
    
    var deleteKeyboard: (() -> Void)?
    
    func saveAlarm(selectedDate: Date, name: String) {
        let selectedDate = selectedDate
        let now = Date()
        
        let correctedDate = selectedDate < now
        ? Calendar.current.date(byAdding: .day, value: 1, to: selectedDate)!
        : selectedDate
        
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        let timeString = formatter.string(from: correctedDate)
        
        let newAlarm = Alarm.createAlarm(clock: timeString, name: name, notificationID: UUID().uuidString)
        
        delegate?.didSaveAlarm(newAlarm)
    }
    
    //метод установки будильника
    func sheduleAlertNotification(date: Date, title: String) {
        
    }
    
    func dismissPresentedScreen() {
        coordinator?.dismissPresentedScreen()
    }
    
    func dismissKeyboard() {
        deleteKeyboard?()
    }
}
