//
//  CoordinateNetworkManager2.swift
//  WeatherApp
//
//  Created by Никита Павлов on 07.06.2025.
//

import Foundation

class CoordinateNetworkManager {
    let apiKey: String = "5c42533f27b084c1b2b5a8319e4060f5"
    
    func sendRequest(city: String, completion: @escaping(Result<(Double, Double), NetworkError>) -> Void) {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.openweathermap.org"
        urlComponents.path = "/geo/1.0/direct"
        
        urlComponents.queryItems = [
            URLQueryItem(name: "q", value: city),
            URLQueryItem(name: "appid", value: apiKey),
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
                let result = try JSONDecoder().decode([CoordinateResponse].self, from: data)
                if let first = result.first {
                    completion(.success((first.lat, first.lon)))
                } else {
                    completion(.failure(.noData))
                }
            } catch {
                completion(.failure(.invalidURL))
            }
        }.resume()
    }
}
