//
//  WeatherNetworkManager.swift
//  WeatherApp
//
//  Created by Никита Павлов on 07.06.2025.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case requestFailed(Error)
    case noData
    case decodingError(Error)
}

final class WeatherNetworkManager {
    
    static let shared = WeatherNetworkManager()
    
    private let apiKey: String = "5c42533f27b084c1b2b5a8319e4060f5"
    private let coordinateNetworkManager = CoordinateNetworkManager()
    
    func fetchWeather(for city: String, completion: @escaping (Result<WeatherResponse, NetworkError>) -> Void) {
            coordinateNetworkManager.sendRequest(city: city) { [weak self] result in
                switch result {
                case .success(let (lat, lon)):
                    self?.sendWeatherRequest(lat: lat, lon: lon, completion: completion)
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    
    func sendWeatherRequest(
        lat: Double,
        lon: Double,
        completion: @escaping (Result<WeatherResponse, NetworkError>) -> Void
    ) {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.openweathermap.org"
        urlComponents.path = "/data/2.5/weather"
        
        urlComponents.queryItems = [
            URLQueryItem(name: "lat", value: String(lat)),
            URLQueryItem(name: "lon", value: String(lon)),
            URLQueryItem(name: "appid", value: apiKey)
        ]
        
        guard let url = urlComponents.url else {
            completion(.failure(.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error {
                completion(.failure(.requestFailed(error)))
                return
            }
            
            guard let data else {
                completion(.failure(.noData))
                return
            }
            
            do {
                let result = try JSONDecoder().decode(WeatherResponse.self, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(.requestFailed(error)))
            }
        }.resume()
    }
}
