//
//  SettingsViewModel.swift
//  InspirationAlarm
//
//  Created by Никита Павлов on 24.06.2025.
//

import Foundation

class SettingsViewModel {
    
    var newAlarmForSetup: ((Alarm) -> Void)?
    
    func saveSettingsTapped(clock: String, name: String) {
        let newAlarm = Alarm(clock: clock, name: name)
        newAlarmForSetup?(newAlarm)
    }
}
