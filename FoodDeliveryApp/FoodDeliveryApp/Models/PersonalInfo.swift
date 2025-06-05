//
//  PersonalInfo.swift
//  FoodDeliveryApp
//
//  Created by Никита Павлов on 30.04.2025.
//

import Foundation

struct PersonalInfo {
    
    let label: String
    let subLabel: String
    let icon: String
    
    // TODO: - Исправить
    static func mockData() -> [PersonalInfo] {
        [
            PersonalInfo(label: "FULL NAME", subLabel: UserDefaults.standard.string(forKey: "fullName") ?? "", icon: "Group 3363"),
            PersonalInfo(label: "EMAIL", subLabel: UserDefaults.standard.string(forKey: "email") ?? "", icon: "Group 3423"),
            PersonalInfo(label: "PHONE NUMBER", subLabel: UserDefaults.standard.string(forKey: "phoneNumber") ?? "", icon: "Group 3425")
        ]
    }
}
