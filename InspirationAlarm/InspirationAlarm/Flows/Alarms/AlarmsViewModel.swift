//
//  AlarmsViewModel.swift
//  InspirationAlarm
//
//  Created by Никита Павлов on 23.06.2025.
//

import Foundation

final class AlarmViewModel {
    // юзер дефолтс private не забываем

    var onAlarmsUpdated: (() -> Void)?
    
    func getAlarms() -> [Alarm] {
        return alarms
    }
    
    func addNewAlarm(_ alarm: Alarm) {
        alarms.append(alarm)
        onAlarmsUpdated?()
    }
    
    func deleteAlarm(at index: Int) {
        guard index >= 0 && index < alarms.count else { return }
        alarms.remove(at: index)
        onAlarmsUpdated?()
    }
}
