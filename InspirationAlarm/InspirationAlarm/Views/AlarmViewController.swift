//
//  ViewController.swift
//  InspirationAlarm
//
//  Created by Никита Павлов on 18.06.2025.
//

import UIKit
import SnapKit

class AlarmViewController: UIViewController {
    
    //MARK: -UI-components
    

    //MARK: -Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        navigationItem.title = "Будильник"

        setupNavigationBarAppearance()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addButtonTapped)
        )
        navigationItem.rightBarButtonItem?.tintColor = .orange
        setupConstraints()
    }
    
    //MARK: -Constraints
    private func setupConstraints() {
        
    }
    
    //MARK: -Logics
    private func setupNavigationBarAppearance() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        
        appearance.largeTitleTextAttributes = [
            .foregroundColor: UIColor.white,
            .font: UIFont.systemFont(ofSize: 36, weight: .bold)
        ]
        
        appearance.titleTextAttributes = [
            .foregroundColor: UIColor.white,
            .font: UIFont.systemFont(ofSize: 18, weight: .semibold)
        ]
        
        appearance.backgroundColor = .systemBackground

        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }

    @objc private func addButtonTapped() {
        print("addButtonTapped")
    }

}

