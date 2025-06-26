//
//  MainCoordinator.swift
//  InspirationAlarm
//
//  Created by Никита Павлов on 25.06.2025.
//

import Foundation
import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get set }
    func start() // 
}

final class MainCoordinator: Coordinator {
    var navigationController: UINavigationController
    private let alarmViewModel = AlarmViewModel()
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let alarmVC = AlarmViewController(viewModel: alarmViewModel)
        alarmVC.coordinator = self
        navigationController.pushViewController(alarmVC, animated: true)
    }
    
    func showSettingsScreen() {
        let settingsViewModel = SettingsViewModel()
        
        settingsViewModel.newAlarmForSetup = { newAlarm in
            self.alarmViewModel.addNewAlarm(newAlarm)
        }
        
        let settingsVC = SettingsViewController(viewModel: settingsViewModel)
        settingsVC.coordinator = self
        
        navigationController.present(settingsVC, animated: true)
    }
    
    func dismissPresentedScreen() {
        navigationController.presentedViewController?.dismiss(animated: true)
    }
}
