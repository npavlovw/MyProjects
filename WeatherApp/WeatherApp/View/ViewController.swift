//
//  ViewController.swift
//  WeatherApp
//
//  Created by Никита Павлов on 05.06.2025.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    private let viewModel = ViewModel()
    private let coordinateNetworkManager = CoordinateNetworkManager()
    private let weatherNetworkManager = WeatherNetworkManager()
    
    //MARK: -UI-Components
    private lazy var mainLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "ПОГОДА"
        label.font = .systemFont(ofSize: 30, weight: .bold)
        return label
    }()
    
    private lazy var searchCityBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Введите город"
        searchBar.searchBarStyle = .minimal
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        
        let textField = searchBar.searchTextField
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            searchBar.heightAnchor.constraint(equalToConstant: 36),
            searchBar.widthAnchor.constraint(greaterThanOrEqualToConstant: 64),
            
            textField.leadingAnchor.constraint(equalTo: searchBar.leadingAnchor, constant: 0),
            textField.trailingAnchor.constraint(equalTo: searchBar.trailingAnchor, constant: 0),
            textField.topAnchor.constraint(equalTo: searchBar.topAnchor, constant: 0),
            textField.bottomAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 0),
        ])
        return searchBar
    }()
    
    private lazy var searchBtn: UIButton = {
        let button = UIButton()
        button.setTitle("Поиск", for: .normal)
        button.backgroundColor = .blue
        button.tintColor = .white
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 36).isActive = true
        button.widthAnchor.constraint(equalToConstant: 80).isActive = true
        return button
    }()
    
    private lazy var searchStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [searchCityBar, searchBtn])
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.spacing = 0
        return stackView
    }()
    
    //MARK: -Lifycycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        searchBtn.addTarget(self, action: #selector(searchCity), for: .touchUpInside)
        setupConstraints()
    }

    private func setupConstraints() {
        view.addSubview(mainLabel)
        view.addSubview(searchStack)
        
        mainLabel.snp.makeConstraints {
            $0.centerX.equalTo(view.snp.centerX)
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(16)
        }
        searchStack.snp.makeConstraints {
            $0.top.equalTo(mainLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalTo(view).inset(16)
        }
    }
    
    //MARK: -Logics
    @objc private func searchCity() {
        let city = searchCityBar.text ?? ""
        weatherNetworkManager.fetchWeather(for: city)
    }
}

