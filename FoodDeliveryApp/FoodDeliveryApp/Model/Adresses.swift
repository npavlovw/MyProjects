//
//  Adresses.swift
//  FoodDeliveryApp
//
//  Created by Никита Павлов on 01.05.2025.
//

import Foundation

struct Adresses{
    
    let image: String
    let name: String
    let description: String
    
    static func makeAdresses() -> [Adresses] {
        [
            Adresses(image: "Home 1", name: "HOME", description: "2464 Royal Ln. Mesa, New Jersey 45463"),
        Adresses(image: "Office", name: "WORK", description: "3891 Ranchview Dr. Richardson, California 62639")
        ]
    }
}
