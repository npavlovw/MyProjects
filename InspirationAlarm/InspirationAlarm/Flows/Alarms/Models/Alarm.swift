//
//  Alarm.swift
//  InspirationAlarm
//
//  Created by Никита Павлов on 23.06.2025.
//

struct Alarm: Codable{
    let clock: String
    let name: String
    var isActive: Bool
    var notificationID: String
    
    static func createAlarm(clock: String, name: String, isActive: Bool = true, notificationID: String) -> Alarm {
        return Alarm(clock: clock, name: name, isActive: isActive, notificationID: notificationID)
    }
}
