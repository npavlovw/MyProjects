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
    
    var temperatureText: ((String) -> Void)?
    
    private var currentKelvinTemp: Double?
    
    func setTemperatureUnit(_ unit: TemperatureUnit) {
        UserDefaults.standard.set(unit.rawValue, forKey: "temperatureUnit")
        updateTemperatureText()
    }
    
    func getTemperatureUnit() -> TemperatureUnit {
        let storedUnitString = UserDefaults.standard.string(forKey: "temperatureUnit") ?? TemperatureUnit.celsius.rawValue
        return TemperatureUnit(rawValue: storedUnitString) ?? .celsius
    }
    
    func setTemperature(_ kelvin: Double) {
        self.currentKelvinTemp = kelvin
        updateTemperatureText()
    }
    
    private func updateTemperatureText() {
        guard let kelvin = currentKelvinTemp else { return }
        
        let unit = getTemperatureUnit()
        let result: String
        
        switch unit {
        case .celsius:
            result = "\(Int(kelvin - 273.15))°C"
        case .fahrenheit:
            result = "\(Int((kelvin - 273.15) * 9/5 + 32))°F"
        }
        
        temperatureText?(result)
    }
}
