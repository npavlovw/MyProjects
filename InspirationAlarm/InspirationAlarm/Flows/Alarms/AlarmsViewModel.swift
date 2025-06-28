//
//  AlarmsViewModel.swift
//  InspirationAlarm
//
//  Created by Никита Павлов on 23.06.2025.
//

import Foundation

final class AlarmViewModel: SettingsViewModelDelegate {
    
    // юзер дефолтс private не забываем
    weak var coordinator: MainCoordinator?
    
    private var alarms: [Alarm] = []
    
    var onAlarmsUpdated: (() -> Void)?
    
    func getAlarms() -> [Alarm] {
        return alarms
    }
    
    func showSettingsScreen (){
        coordinator?.showSettingsScreen(with: self)
    }
    
    func didSaveAlarm(_ alarm: Alarm) {
        alarms.append(alarm)
        onAlarmsUpdated?()
    }
    
//    func showNewAlarm() {
//        if let savedData = UserDefaults.standard.data(forKey: "alarm"),
//           let newAlarm = try? JSONDecoder().decode(Alarm.self, from: savedData) {
//            addNewAlarm(newAlarm)
//        }
//    }
        
   func deleteAlarm(at index: Int) {
        guard index >= 0 && index < alarms.count else { return }
        alarms.remove(at: index)
        onAlarmsUpdated?()
    }
}

