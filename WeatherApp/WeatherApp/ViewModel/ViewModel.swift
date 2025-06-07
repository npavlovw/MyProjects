//
//  ViewModel.swift
//  WeatherApp
//
//  Created by Никита Павлов on 06.06.2025.
//

import Foundation
import SnapKit

class ViewModel {
    
    // MARK: - Outputs (данные, которые ViewController будет отображать)
    var temperatureText: ((String) -> Void)?
    var weatherText: ((String) -> Void)?
    var feelsLikeText: ((String) -> Void)?
    var pressureText: ((String) -> Void)?
    var humidityText: ((String) -> Void)?
    var windText: ((String) -> Void)?
    var rainText: ((String) -> Void)?
    
    // MARK: - Public method to fetch weather
    func fetchWeather(for city: String) {
        WeatherNetworkManager.shared.fetchWeather(for: city) { [weak self] _ in
            guard self != nil else { return }
        }
    }
    
    func descriptionForWeatherId(_ id: Int) -> String {
        switch id {
        case 200...232:
            return "Гроза"
        case 300...321:
            return "Морось"
        case 500...531:
            return "Дождь"
        case 600...622:
            return "Снег"
        case 701...781:
            return "Туман"
        case 800:
            return "Ясно"
        case 801...804:
            return "Облачно"
        default:
            return "Неизвестно"
        }
    }
}
