//
//  AlarmsViewModel.swift
//  InspirationAlarm
//
//  Created by Никита Павлов on 23.06.2025.
//

import UserNotifications

final class AlarmViewModel: SettingsViewModelDelegate {
    
    weak var coordinator: MainCoordinator?
    let quoteNetworkManager = QuoteNetworkManager()
    
    private var alarms: [Alarm] = []
    
    var onAlarmsUpdated: (() -> Void)?
    
    func getAlarms() -> [Alarm] {
        return alarms
    }
    
    func showSettingsScreen () {
        coordinator?.showSettingsScreen(with: self)
    }
    
    func showSavedAlarms() {
        if let data = UserDefaults.standard.data(forKey: "savedAlarms"),
           let savedAlarms = try? JSONDecoder().decode([Alarm].self, from: data) {
            self.alarms = savedAlarms
            onAlarmsUpdated?()
        }
    }
    
    //добавление нового будильника в массив и сразу же установка его
    func didSaveAlarm(_ alarm: Alarm) {
        alarms.append(alarm)
        onAlarmsUpdated?()
        didSetAlarm(alarm: alarm)
    }
    
    //проверка при переключении вкл/выкл будильника
    func checkSwitch(isOn: Bool, at index: Int) {
        alarms[index].isActive = isOn
        let alarm = alarms[index]

        if isOn {
            didSetAlarm(alarm: alarm)
            print("Будильник с индексом \(alarm.notificationID) включён")
        } else {
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [alarm.notificationID])
            print("Будильник с индексом \(alarm.notificationID) выключен")
        }
        
        saveAlarmsForExit()
    }
    
    //метод конвертирует String в Date
    func convertClockToDate(clock: String) -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        formatter.locale = Locale(identifier: "ru_RU")

        guard let timeOnlyDate = formatter.date(from: clock) else {
            return Date()
        }

        var dateComponents = Calendar.current.dateComponents([.year, .month, .day], from: Date())
            
        let timeComponents = Calendar.current.dateComponents([.hour, .minute], from: timeOnlyDate)
        
        dateComponents.hour = timeComponents.hour
        dateComponents.minute = timeComponents.minute
            
        return Calendar.current.date(from: dateComponents) ?? Date()
    }
    
    //установка будильника
    func didSetAlarm(alarm: Alarm) {
        getQuote { [weak self] quote in
            guard let self = self, let quote = quote else { return }
            
            let content = UNMutableNotificationContent()
            content.title = alarm.name
            content.body = quote
            content.sound = UNNotificationSound.default
            
            let date = convertClockToDate(clock: alarm.clock)
            
            let triggerDate = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: date)
            let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)
            
            let request = UNNotificationRequest(identifier: alarm.notificationID, content: content, trigger: trigger)
            
            UNUserNotificationCenter.current().add(request) { error in
                if let error = error {
                    print("❌ Ошибка при добавлении уведомления: \(error)")
                } else {
                    print("🔔 Уведомление запланировано")
                }
            }
        }
    }
    
    func getQuote(completion: @escaping (String?) -> Void) {
        quoteNetworkManager.fetchRandomQuote { quote in
            if let quote = quote {
                completion("\(quote.q) - \(quote.a)")
            } else {
                completion(nil)
            }
        }
    }
    
    func saveAlarmsForExit() {
        if let data = try? JSONEncoder().encode(alarms) {
            UserDefaults.standard.set(data, forKey: "savedAlarms")
        }
    }
    
    func deleteAlarm(at index: Int) {
        guard index >= 0 && index < alarms.count else { return }
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [alarms[index].notificationID])
        alarms.remove(at: index)
        onAlarmsUpdated?()
        saveAlarmsForExit()
    }
}

