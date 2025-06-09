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
    private let weatherID = WeatherID()
    
    //MARK: -UI-Components
    private lazy var mainLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "ПОГОДА"
        label.font = .systemFont(ofSize: 30, weight: .bold)
        return label
    }()
    
    private lazy var settingsButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "ellipsis.circle"), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(showTemperatureUnitAlert), for: .touchUpInside)
        return button
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
        button.addTarget(self, action: #selector(showWeather), for: .touchUpInside)
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
    
    private lazy var weatherImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    //MARK: -Lifycycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupConstraints()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
        searchCityBar.delegate = self
        searchCityBar.text = UserDefaults.standard.string(forKey: "city")
        checkSearchBar()
        viewModel.temperatureText = { [weak self] text in
            DispatchQueue.main.async {
                self?.temperatureLabel.text = text
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        UserDefaults.standard.set(searchCityBar.text, forKey: "city")
    }
    
    private func setupConstraints() {
        view.addSubview(mainLabel)
        view.addSubview(settingsButton)
        view.addSubview(searchStack)
        view.addSubview(weatherStack)
        view.addSubview(weatherImageView)
        
        mainLabel.snp.makeConstraints {
            $0.centerX.equalTo(view.snp.centerX)
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(16)
        }
        settingsButton.snp.makeConstraints {
            $0.centerY.equalTo(mainLabel.snp.centerY)
            $0.trailing.equalTo(view.snp.trailing).inset(16)
            $0.height.width.equalTo(mainLabel.snp.height)
        }
        searchStack.snp.makeConstraints {
            $0.top.equalTo(mainLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalTo(view).inset(16)
        }
        weatherStack.snp.makeConstraints {
            $0.top.equalTo(searchStack.snp.bottom).offset(24)
            $0.leading.trailing.equalTo(view).inset(16)
        }
        weatherImageView.snp.makeConstraints {
            $0.leading.trailing.equalTo(view).inset(16)
            $0.height.equalTo(200)
            $0.top.equalTo(weatherStack.snp.bottom).offset(24)
        }
    }
    
    //MARK: - Logic
    private func checkSearchBar() {
        guard let text = searchCityBar.text, !text.isEmpty else { return }
        showWeather()
    }
    
    @objc private func showWeather() {
        let city = searchCityBar.text ?? ""
        cityLabel.text = city
        
        UserDefaults.standard.set(city, forKey: "city")
        
        weatherNetworkManager.fetchWeather(for: city) { [weak self] weather in
            guard let self else { return }
            
            DispatchQueue.main.async {
                
                switch weather {
                case .success(let weatherResponse):
                    let weather = weatherResponse.weather
                    let id = weather[0].id
                    let description = self.weatherID.descriptionForWeatherId(id)
                    let nameImage = self.weatherID.imageForWeatherId(id)
                    
                    self.viewModel.setTemperature(weatherResponse.main.temp)
                    self.weatherLabel.text = description
                    self.feelsLikeLabel.text = "Ощущается как: \(Int(weatherResponse.main.feels_like - 273.15))°C"
                    self.pressureLabel.text = "Давление: \(weatherResponse.main.pressure * 0.75) мм рт ст"
                    self.humidityLabel.text = "Влажность: \(weatherResponse.main.humidity)%"
                    self.windLabel.text = "Ветер: \(weatherResponse.wind.speed) м/с"
                    self.weatherImageView.image = UIImage(named: nameImage)
                case .failure(let error):
                    print("Ошибка: \(error)")
                }
            }
        }
    }
    
    @objc private func showTemperatureUnitAlert() {
        let alert = UIAlertController(
            title: "В каких единицах показывать температуру?",
            message: nil,
            preferredStyle: .actionSheet
        )
        let celsiusAction = UIAlertAction(title: "Градусы Цельсия", style: .default) { [weak self] _ in
            self?.viewModel.setTemperatureUnit(.celsius)
        }
        let fahrenheitAction = UIAlertAction(title: "Градусы Фарентгейт", style: .default) { [weak self] _ in
            self?.viewModel.setTemperatureUnit(.fahrenheit)
        }
        
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel)
        
        alert.addAction(celsiusAction)
        alert.addAction(fahrenheitAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension ViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        showWeather()
        searchBar.resignFirstResponder()
    }
}
