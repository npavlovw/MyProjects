//
//  Coordinator.swift
//  InspirationAlarm
//
//  Created by Никита Павлов on 25.06.2025.
//

import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get set }
    func start()
}
