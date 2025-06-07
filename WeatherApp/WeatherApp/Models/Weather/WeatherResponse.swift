//
//  WeatherResponse.swift
//  WeatherApp
//
//  Created by Никита Павлов on 07.06.2025.
//

struct WeatherResponse: Decodable {
    let weather: [Weather]
    let main: Main
    let visibility: Int
    let wind: Wind
}

struct Weather: Decodable {
    let id: Int
    let icon: String
}

struct Main: Decodable {
    let temp: Double
    let feels_like: Double
    let pressure: Double
    let humidity: Double
}

struct Wind: Decodable {
    let speed: Double
}

