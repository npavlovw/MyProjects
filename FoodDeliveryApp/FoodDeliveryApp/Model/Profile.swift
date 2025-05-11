//
//  Profile.swift
//  FoodDeliveryApp
//
//  Created by Никита Павлов on 26.04.2025.
//

import Foundation

struct Profile: Equatable{
    
    let label: String
    let image: String
    
    static func makeData() -> [[Profile]] {
        [
            [
            Profile(label: "Personal Info", image: "Group 3363"),
            Profile(label: "Addresses", image: "map")
        ],
         [
            Profile(label: "Cart", image: "Group 2730"),
            Profile(label: "Favourite", image: "Vector 2"),
            Profile(label: "Notifications", image: "Group 2731"),
            Profile(label: "Payment Method", image: "Group 2732")
         ],
         [
            Profile(label: "FAQs", image: "Group 2733"),
            Profile(label: "User Reviews", image: "Vector 3"),
            Profile(label: "Settings", image: "Group 3366")
         ],
         [
            Profile(label: "Log Out", image: "Logout 1")
         ]
        ]
    }
}
