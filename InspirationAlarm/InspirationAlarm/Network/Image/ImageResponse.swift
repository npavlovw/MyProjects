//
//  Image.swift
//  InspirationAlarm
//
//  Created by Никита Павлов on 29.06.2025.
//
import Foundation

struct ImageResponse: Decodable {
    let urls: ImageURL
}

struct ImageURL: Decodable {
    let regular: String
}
