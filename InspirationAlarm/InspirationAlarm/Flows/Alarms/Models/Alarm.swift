//
//  Alarm.swift
//  InspirationAlarm
//
//  Created by Никита Павлов on 23.06.2025.
//

struct Alarm: Codable{
    var clock: String
    var name: String
    var isActive: Bool
    
    static func createAlarm(clock: String, name: String, isActive: Bool = true) -> Alarm {
        return Alarm(clock: clock, name: name, isActive: isActive)
    }
}
