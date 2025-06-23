//
//  Alarm.swift
//  InspirationAlarm
//
//  Created by Никита Павлов on 23.06.2025.
//

import Foundation

struct Alarm {
    var clock: String
    var name: String
    var isActive: Bool = false
    
    static func setAlarms() -> [Alarm] {
        [
            Alarm(clock: "12:30", name: "alarm"),
            Alarm(clock: "12:30", name: "alarm"),
            Alarm(clock: "12:30", name: "alarm"),
            Alarm(clock: "12:30", name: "alarm"),
            Alarm(clock: "12:30", name: "alarm"),
            Alarm(clock: "12:30", name: "alarm"),
            Alarm(clock: "12:30", name: "alarm"),
            Alarm(clock: "12:30", name: "alarm"),
            Alarm(clock: "12:30", name: "alarm"),
            Alarm(clock: "12:30", name: "alarm"),
            Alarm(clock: "12:30", name: "alarm"),
            Alarm(clock: "12:30", name: "alarm"),
            Alarm(clock: "12:30", name: "alarm"),
            Alarm(clock: "12:30", name: "alarm"),
        ]
    }
}
