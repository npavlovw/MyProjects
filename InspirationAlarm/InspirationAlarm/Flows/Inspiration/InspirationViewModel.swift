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
            DispatchQueue.main.async {
                if let data = try? Data(contentsOf: url) {
                    self.imageData?(data)
                }
            }
        }
    }
}
