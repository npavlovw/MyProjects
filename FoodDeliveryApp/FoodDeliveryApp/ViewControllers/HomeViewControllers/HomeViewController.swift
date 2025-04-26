//
//  HomeViewController.swift
//  FoodDeliveryApp
//
//  Created by Никита Павлов on 24.04.2025.
//

import UIKit
import SnapKit

class HomeViewController: UIViewController {
    
    private lazy var menuButton = CustomButton(target: self, action: #selector(menuTupped), backgroundColor: .btnGray, image: UIImage(named: "menuIcon")!)
    
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setConstraints()
    }
    
    private func setConstraints() {
        view.addSubview(menuButton)
        
        menuButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(screenHeight*54/812)
            make.leading.equalToSuperview().offset(screenWidth*24/375)
        }
    }
    
    @objc private func menuTupped() {
        let menuVC = ProfileViewController()
        navigationController?.pushViewController(menuVC, animated: true)
    }

}
