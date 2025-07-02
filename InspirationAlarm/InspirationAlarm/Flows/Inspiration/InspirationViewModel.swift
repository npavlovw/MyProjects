//
//  InspirationViewModel.swift
//  InspirationAlarm
//
//  Created by Никита Павлов on 01.07.2025.
//
import Foundation

class InspirationViewModel{
    
    weak var coordinator: MainCoordinator?
    
    var imageData: ((Data) ->Void)?
    
    func loadImage(){
        ImageNetworkManager.shared.sendRequest { url in
            guard let url = url else { return }
            
            URLSession.shared.dataTask(with: url) { data, _, error in
                guard let data = data, error == nil else {
                    print("Ошибка загрузки изображения: \(error?.localizedDescription ?? "Нет описания")")
                    return
                }
                DispatchQueue.main.async {
                        self.imageData?(data)
                }
            }.resume()
        }
    }
}
