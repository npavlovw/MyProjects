//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Никита Павлов on 10.06.2025.
//

import Foundation

class WeatherViewModel {
    
    var onDataUpdate: ((WeatherResponse) -> Void)?
    var onError: ((String) -> Void)?
    
    func fetchData(for city: String) {
        guard isValidCity(city) else {
                    onError?("Введите корректное название города")
                    return
                }
        
        WeatherNetworkManager.shared.fetchWeather(for: city) { result in
            switch result {
                case .success(let weather):
                    self.onDataUpdate?(weather)
                case .failure(let error):
                    self.onError?(error.localizedDescription)
            }
        }
    }
    
    private func isValidCity(_ city: String) -> Bool {
        return !city.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    func getPressure(_ value: Double) -> String {
        return "Давление: \(value * 0.75) мм. рт. ст."
    }
    
    func getHumidity(_ value: Double) -> String {
        return "Влажность: \(value)%"
    }
    
    func getWindSpeed(_ value: Double) -> String {
        return "Скорость ветра: \(value) м/с"
    }
    
    func getWeatherDescription(id: Int) -> (message: String, imageName: String) {
        let weather = WeatherID(rawValue: id)
        let message = weather?.message ?? ""
        let imageName = weather?.imageForWeather ?? ""
        return (message,imageName)
    }
    
    
    //MARK: - TemperatureUnit
    enum TemperatureUnit: String {
        case celsius = "°C"
        case fahrenheit = "°F"
    }
    
    var temperatureText: ((String) -> Void)?
    var feelsLike: ((String) -> Void)?
    private var currentKelvinTemp: Double?
    private var currentFeelsLikeKelvinTemp: Double?
    
    //метод вызывается, когда направляем запрос в интернет и получаем ответ
    func setTemperature(_ kelvin: Double) {
            self.currentKelvinTemp = kelvin
            updateTemperatureText()
    }
    
    //Метод вызывается когда мы меняем единицу измерения температуры
    func setTemperatureUnit(_ unit: TemperatureUnit) {
        UserDefaults.standard.set(unit.rawValue, forKey: "temperatureUnit")
        updateTemperatureText()
    }
    
    
    func getTemperatureUnit() -> TemperatureUnit {
        let storedUnitString = UserDefaults.standard.string(forKey: "temperatureUnit") ?? TemperatureUnit.celsius.rawValue
        return TemperatureUnit(rawValue: storedUnitString) ?? .celsius
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
    
    func setFeelsLikeTemperature(_ kelvin: Double) {
        self.currentFeelsLikeKelvinTemp = kelvin
        updateFeelsLikeTemperatureText()
    }
    
    func setFeelsLikeTemperatureUnit(_ unit: TemperatureUnit) {
        UserDefaults.standard.set(unit.rawValue, forKey: "feelsLikeTemperatureUnit")
        updateFeelsLikeTemperatureText()
    }
    
    private func getFeelsLikeTemperatureUnit() -> TemperatureUnit {
        let storedUnitString = UserDefaults.standard.string(forKey: "feelsLikeTemperatureUnit") ?? TemperatureUnit.celsius.rawValue
        return TemperatureUnit(rawValue: storedUnitString) ?? .celsius
    }
    
    private func updateFeelsLikeTemperatureText() {
        guard let kelvin = currentFeelsLikeKelvinTemp else { return }
        
        let unit = getFeelsLikeTemperatureUnit()
        let result: String
        
        switch unit {
        case .celsius:
            result = "\(Int(kelvin - 273.15))°C"
        case .fahrenheit:
            result = "\(Int((kelvin - 273.15) * 9/5 + 32))°F"
        }
        
        feelsLike?(result)
    }
}
