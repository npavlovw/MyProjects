//
//  Image.swift
//  InspirationAlarm
//
//  Created by Никита Павлов on 29.06.2025.
//

struct ImageResponse: Decodable {
    let url: ImageURL
}

struct ImageURL: Decodable {
    let regular: String
}
