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
    
    private lazy var cityLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = .systemFont(ofSize: 19, weight: .medium)
        return label
    }()
    
    private lazy var temperatureLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = .systemFont(ofSize: 19, weight: .medium)
        return label
    }()
    
    private lazy var weatherLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = .systemFont(ofSize: 19, weight: .medium)
        return label
    }()
    
    private lazy var feelsLikeLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = .systemFont(ofSize: 19, weight: .medium)
        return label
    }()
    
    private lazy var pressureLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = .systemFont(ofSize: 19, weight: .medium)
        return label
    }()
    
    private lazy var humidityLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = .systemFont(ofSize: 19, weight: .medium)
        return label
    }()
    
    private lazy var windLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = .systemFont(ofSize: 19, weight: .medium)
        return label
    }()
    
    private lazy var weatherStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [temperatureLabel, weatherLabel, feelsLikeLabel, pressureLabel, humidityLabel, windLabel])
        stack.axis = .vertical
        stack.spacing = 8
        stack.alignment = .leading
        return stack
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
        view.addSubview(weatherStack)
        
        mainLabel.snp.makeConstraints {
            $0.centerX.equalTo(view.snp.centerX)
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(16)
        }
        searchStack.snp.makeConstraints {
            $0.top.equalTo(mainLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalTo(view).inset(16)
        }
        weatherStack.snp.makeConstraints {
            $0.top.equalTo(searchStack.snp.bottom).offset(24)
            $0.leading.trailing.equalTo(view).inset(16)
        }
    }
    
    //MARK: -Logics
    @objc private func searchCity() {
        let city = searchCityBar.text ?? ""
        cityLabel.text = city
        
        weatherNetworkManager.fetchWeather(for: city) { [weak self] weather in
            guard let self, let weather else { return }
            
            
            DispatchQueue.main.async {
                let id = weather.weather[0].id
                let description = self.viewModel.descriptionForWeatherId(id)
                
                self.temperatureLabel.text = "\(Int(weather.main.temp - 273.15))°C"
                self.weatherLabel.text = description
                self.feelsLikeLabel.text = "Ощущается как: \(Int(weather.main.feels_like - 273.15))°C"
                self.pressureLabel.text = "Давление: \(weather.main.pressure * 0.75) мм рт ст"
                self.humidityLabel.text = "Влажность: \(weather.main.humidity)%"
                self.windLabel.text = "Ветер: \(weather.wind.speed) м/с"
            }
        }
    }
}

