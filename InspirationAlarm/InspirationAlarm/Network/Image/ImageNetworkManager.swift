//
//  ImageNetworkManager.swift
//  InspirationAlarm
//
//  Created by Никита Павлов on 29.06.2025.
//

import Foundation

class ImageNetworkManager {
    let apiKey: String = "rzgwC_c2KEpleQW46_NGvOJ6pFq_xqYsKgMLC9NQaDE"
    let url: String = "https://api.unsplash.com/photos/random"
        
    func sendRequest(completion: @escaping(URL?) -> Void){
        
        var urlComponents = URLComponents(string: url)
        urlComponents?.queryItems = [
            URLQueryItem(name: "client_id", value: apiKey),
            URLQueryItem(name: "query", value: "inspiretion"),
        ]
        
        guard let url = urlComponents?.url else { return }
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            
            guard let data else { return}
            
            do {
                let result = try JSONDecoder().decode(ImageResponse.self, from: data)
                completion(URL(string: result.url.regular))
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
}
