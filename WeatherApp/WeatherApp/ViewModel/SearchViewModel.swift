//
//  ViewModel.swift
//  WeatherApp
//
//  Created by Никита Павлов on 06.06.2025.
//

import Foundation

class SearchViewModel {
    
    func saveCity(_ city: String) {
        UserDefaults.standard.set(city, forKey: "city")
    }
    
    func loadSavedCity() -> String {
            return UserDefaults.standard.string(forKey: "city") ?? ""
    }
}
