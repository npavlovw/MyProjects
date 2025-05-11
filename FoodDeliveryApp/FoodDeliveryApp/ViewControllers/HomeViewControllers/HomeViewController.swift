//
//  HomeViewController.swift
//  FoodDeliveryApp
//
//  Created by Никита Павлов on 24.04.2025.
//

import UIKit
import SnapKit

class HomeViewController: UIViewController {
    
    //MARK: -UI-Components
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
    private lazy var setLocationButton: UIButton = {
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
        return $0
    }(UIStackView(arrangedSubviews: [locationLabel, setLocationButton]))
    private lazy var badgeView: UIView = {
        $0.backgroundColor = .appOrange
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.widthAnchor.constraint(equalToConstant: 25).isActive = true
        $0.heightAnchor.constraint(equalToConstant: 25).isActive = true
        $0.layer.cornerRadius = 12.5
        return $0
    }(UIView())
    private lazy var badgeLabel: UILabel = {
        $0.text = "2"
        $0.font = .systemFont(ofSize: 12, weight: .bold)
        $0.textColor = .white
        $0.textAlignment = .center
        return $0
    }(UILabel())
    
    let locations = ["Halal Lab office", "Home", "Work"]
    private lazy var basketButton = CustomButton(target: self, action: #selector(basketButtonTapped), backgroundColor: .logInBackground, image: UIImage(named: "Icon")!)
    
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height

    //MARK: -Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setConstraints()
    }
    
    //MARK: -Constraints
    private func setConstraints() {
        [menuButton, deliverToLabel, locationStack, basketButton].forEach {
            view.addSubview($0)
        }
        basketButton.addSubview(badgeView)
        badgeView.addSubview(badgeLabel)
        
        menuButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(screenHeight*54/812)
            make.leading.equalToSuperview().offset(screenWidth*24/375)
        }
        basketButton.snp.makeConstraints { make in
            make.centerY.equalTo(menuButton.snp.centerY)
            make.trailing.equalToSuperview().inset(screenWidth*24/375)
            make.leading.greaterThanOrEqualTo(setLocationButton.snp.trailing).offset(8)
        }
        deliverToLabel.snp.makeConstraints { make in
            make.leading.equalTo(menuButton.snp.trailing).offset(18)
            make.top.equalToSuperview().offset(screenHeight*59/812)
        }
        locationStack.snp.makeConstraints { make in
            make.top.equalTo(deliverToLabel.snp.bottom).offset(3)
            make.leading.equalTo(deliverToLabel.snp.leading)
            make.trailing.lessThanOrEqualTo(basketButton.snp.leading).offset(-8)
        }
        badgeView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(-4)
            make.trailing.equalToSuperview()
        }
        badgeLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        locationLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        setLocationButton.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
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
    
    @objc private func basketButtonTapped() {
        print ("basketButtonTapped")
    }
    
    private func checkBadgeLabelText() {
        if badgeLabel.text == "0" {
            badgeView.isHidden = true
        } else {
            badgeView.isHidden = false
        }
    }

}
