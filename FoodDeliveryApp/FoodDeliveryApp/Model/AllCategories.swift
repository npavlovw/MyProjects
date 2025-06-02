//
//  HomeAllCategories.swift
//  FoodDeliveryApp
//
//  Created by Никита Павлов on 11.05.2025.
//

import Foundation

struct AllCategories {
    var name: String
    var isSelected: Bool = false
    
    static func mockData() -> [AllCategories] {
        [
            AllCategories(name: "All"),
            AllCategories(name: "Hot Dog"),
            AllCategories(name: "Burgers"),
            AllCategories(name: "Pizza"),
            AllCategories(name: "Pasta")
            ]
    }
}
