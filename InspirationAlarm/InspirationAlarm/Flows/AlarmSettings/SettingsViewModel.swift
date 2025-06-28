//
//  SettingsViewModel.swift
//  InspirationAlarm
//
//  Created by Никита Павлов on 24.06.2025.
//

import Foundation
import UserNotifications

protocol SettingsViewModelDelegate: AnyObject {
    func didSaveAlarm(_ alarm: Alarm)
}

final class SettingsViewModel {
    
    weak var coordinator: MainCoordinator?
    
    weak var delegate: SettingsViewModelDelegate?
    
//    func saveSettings(clock: String, name: String) {
//        let newAlarm = Alarm(clock: clock, name: name, isActive: true)
//    }
    
    func sheduleAlertNotification(date: Date, title: String) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = "Будильник сработал!"
        content.sound = UNNotificationSound.default
        
        let triggerDate = Calendar.current.dateComponents([.hour, .minute], from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("❌ Ошибка при добавлении уведомления: \(error)")
            } else {
                print("🔔 Уведомление запланировано")
            }
        }
    }
    
    func dismissPresentedScreen() {
        coordinator?.dismissPresentedScreen()
    }
    
    func saveAlarm(alarm: Alarm) {
        if let encoded = try? JSONEncoder().encode(alarm) {
            UserDefaults.standard.set(encoded, forKey: "alarm")
        }
        delegate?.didSaveAlarm(alarm)
    }
}
