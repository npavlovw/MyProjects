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
    private lazy var deliverToLabel: UILabel = {
        $0.text = "DELIVER TO"
        $0.font = .systemFont(ofSize: 12, weight: .bold)
        $0.textColor = .appOrange
        return $0
    }(UILabel())
    private lazy var locationLabel: UILabel = {
        $0.text = "Halal Lab office"
        $0.textColor = UIColor(red: 103/255, green: 103/255, blue: 103/255, alpha: 1)
        $0.font = .systemFont(ofSize: 14, weight: .medium)
        return $0
    }(UILabel())
    private lazy var  setLocationButton: UIButton = {
        let image = UIImage(named: "Polygon 2")?.withRenderingMode(.alwaysTemplate)
        $0.setImage(image, for: .normal)
        $0.tintColor = UIColor(red: 24/255, green: 28/255, blue: 46/255, alpha: 1)
        $0.addTarget(self, action: #selector(setLocationButtonTapped), for: .touchUpInside)
        return $0
    }(UIButton(type: .system))
    private lazy var locationStack: UIStackView = {
        $0.axis = .horizontal
        $0.spacing = 8
        $0.alignment = .center
        $0.distribution = .fill
        return $0
    }(UIStackView(arrangedSubviews: [locationLabel, setLocationButton]))
    private lazy var setDeliveryStack: UIStackView = {
        $0.axis = .vertical
        $0.spacing = 3
        $0.alignment = .leading
        return $0
    }(UIStackView(arrangedSubviews: [deliverToLabel, locationStack]))
    let locations = ["Halal Lab office", "Home", "Work", "Other"]
    
    
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setConstraints()
    }
    
    private func setConstraints() {
        [menuButton, setDeliveryStack].forEach {
            view.addSubview($0)
        }
        
        menuButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(screenHeight*54/812)
            make.leading.equalToSuperview().offset(screenWidth*24/375)
        }
        setDeliveryStack.snp.makeConstraints { make in
            make.leading.equalTo(menuButton.snp.trailing).offset(18)
            make.top.equalToSuperview().offset(screenHeight*59/812)
        }
    }
    
    //MARK: -Logics
    @objc private func menuTupped() {
        let menuVC = ProfileViewController()
        navigationController?.pushViewController(menuVC, animated: true)
    }
    
    @objc private func setLocationButtonTapped() {
        let alertController = UIAlertController(title: "Deliver to", message: nil, preferredStyle: .actionSheet)
        
        for location in locations {
            let action = UIAlertAction(title: location, style: .default) { _ in
                self.locationLabel.text = location
            }
            alertController.addAction(action)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true)
    }

}
