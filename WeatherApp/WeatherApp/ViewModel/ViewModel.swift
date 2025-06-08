//
//  ViewModel.swift
//  WeatherApp
//
//  Created by Никита Павлов on 06.06.2025.
//

import Foundation

class ViewModel {
    
    // MARK: - Public method to fetch weather
    func fetchWeather(for city: String) {
        WeatherNetworkManager.shared.fetchWeather(for: city) { [weak self] _ in
            guard self != nil else { return }
        }
    }
    
    enum TemperatureUnit: String {
        case celsius = "°C"
        case fahrenheit = "°F"
    }
    
    func setTemperatureUnit(_ unit: TemperatureUnit) {
        UserDefaults.standard.set(unit.rawValue, forKey: "temperatureUnit")
        
    }
}
