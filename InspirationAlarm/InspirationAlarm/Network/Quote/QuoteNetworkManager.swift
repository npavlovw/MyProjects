//
//  QuoteNetworkManager.swift
//  InspirationAlarm
//
//  Created by Никита Павлов on 29.06.2025.
//

import Foundation

final class QuoteNetworkManager {
    func fetchRandomQuote(completion: @escaping (QuoteResponse?) -> Void) {
        let urlString = "https://zenquotes.io/api/random"
        guard let url = URL(string: urlString) else {
            print("Ошибка: некорректный URL")
            completion(nil)
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            
            guard let data else { return }
            
            do {
                let quote = try JSONDecoder().decode([QuoteResponse].self, from: data)
                completion(quote.first)
            } catch {
                print("Ошибка при парсинге: \(error)")
                completion(nil)
            }
        }.resume()
    }
}
