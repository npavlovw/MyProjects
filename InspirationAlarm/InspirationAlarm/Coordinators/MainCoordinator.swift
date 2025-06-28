//
//  MainCoordinator.swift
//  InspirationAlarm
//
//  Created by Никита Павлов on 25.06.2025.
//

import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get set }
    func showAlarmScreen()
}

final class MainCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func showAlarmScreen() {
        let alarmViewModel = AlarmViewModel()
        alarmViewModel.coordinator = self
        let alarmVC = AlarmViewController(viewModel: alarmViewModel)
        navigationController.pushViewController(alarmVC, animated: true)
    }
    
    func showSettingsScreen(with delegate: SettingsViewModelDelegate) {
        let settingsViewModel = SettingsViewModel()
        settingsViewModel.coordinator = self
        settingsViewModel.delegate = delegate
        let settingsVC = SettingsViewController(viewModel: settingsViewModel)
        navigationController.present(settingsVC, animated: true)
    }
    
    func dismissPresentedScreen() {
        navigationController.presentedViewController?.dismiss(animated: true)
    }
}
