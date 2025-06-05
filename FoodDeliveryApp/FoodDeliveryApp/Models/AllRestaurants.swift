//
//  HomeRestaurants.swift
//  FoodDeliveryApp
//
//  Created by Никита Павлов on 01.06.2025.
//

import Foundation

enum Deliver: String {
    case free, paid
}

// TODO: - Исправить на Restaurant
struct AllRestaurants {
    var name: String
    var food: [String]
    var grade: Double
    var deliver: Deliver
    var time: String
    var isSelected: Bool = false
    
    static func mockData() -> [AllRestaurants] {
        [
            AllRestaurants(
                name: "Rose Garden Restaurant",
                food: ["Burger", "Chiken", "Riche", "Wings"],
                grade: 4.7,
                deliver: .free,
                time: "20 min"
            ),
            AllRestaurants(
                name: "Border Restaurant",
                food: ["Pizza", "Burgers", "Pasta", "Sushi"],
                grade: 4.5,
                deliver: .paid,
                time: "15 min"
            ),
            AllRestaurants(
                name: "Dodo",
                food: ["Pizza"],
                grade: 4.8,
                deliver: .free,
                time: "10 min"
            ),
            AllRestaurants(
                name: "Japan Restaurant",
                food: ["Fish", "Sushi"],
                grade: 4.4,
                deliver: .free,
                time: "20 min"
            )
        ]
    }
    
}
