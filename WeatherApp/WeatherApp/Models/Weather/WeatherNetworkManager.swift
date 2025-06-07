//
//  WeatherNetworkManager.swift
//  WeatherApp
//
//  Created by Никита Павлов on 07.06.2025.
//

import Foundation

class WeatherNetworkManager {
    static let shared = WeatherNetworkManager()
    
    let apiKey: String = "5c42533f27b084c1b2b5a8319e4060f5"
    let coordinateNetworkManager = CoordinateNetworkManager()
    
    func fetchWeather(for city: String, completion: @escaping (WeatherResponse?) -> Void) {
        coordinateNetworkManager.sendRequest(city: city) { lat, lon in
            self.sendWeatherRequest(lat: lat, lon: lon) { weather in
                completion(weather)
            }
        }
    }
    
    func sendWeatherRequest(lat: Double, lon: Double, completion: @escaping (WeatherResponse?) -> Void) {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.openweathermap.org"
        urlComponents.path = "/data/2.5/weather"
        
        urlComponents.queryItems = [
            URLQueryItem(name: "lat", value: String(lat)),
            URLQueryItem(name: "lon", value: String(lon)),
            URLQueryItem(name: "appid", value: apiKey)
        ]
        
        guard let url = urlComponents.url else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            
            guard let data else { return }
            
            do {
                let result = try JSONDecoder().decode(WeatherResponse.self, from: data)
                completion(result)
            } catch {
                print(error.localizedDescription)
                completion(nil)
            }
        }.resume()
    }
}
