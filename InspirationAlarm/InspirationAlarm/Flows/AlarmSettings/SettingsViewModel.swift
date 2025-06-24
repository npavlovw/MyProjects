//
//  SettingsViewModel.swift
//  InspirationAlarm
//
//  Created by Никита Павлов on 24.06.2025.
//

import Foundation

class SettingsViewModel {
    
    var cancel: (() -> Void)?
    var settings: (() -> Void)?
    
    func cancelTapped() {
        cancel?()
    }
    
    func saveSettingsTapped() {
        settings?()
    }
}
