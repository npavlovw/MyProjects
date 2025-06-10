//
//  WeatherViewController.swift
//  WeatherApp
//
//  Created by Никита Павлов on 10.06.2025.
//

import UIKit

class WeatherViewController: UIViewController {
    
    private let viewModel = WeatherViewModel()
    private let weatherNetworkManager = WeatherNetworkManager()
    private let weatherID = WeatherID()

    var savedCity: String?
    
    //MARK: -UI-Components
    private lazy var settingsButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "ellipsis.circle"), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(showTemperatureUnitAlert), for: .touchUpInside)
        return button
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
        showWeather()
        viewModel.temperatureText = { [weak self] text in
            DispatchQueue.main.async {
                self?.temperatureLabel.text = text
            }
        }
    }
    
    //MARK: - Constraints
    private func setupConstraints() {
        view.addSubview(settingsButton)
        view.addSubview(weatherStack)
        view.addSubview(weatherImageView)
        
        settingsButton.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(12)
            $0.trailing.equalTo(view.snp.trailing).inset(12)
            $0.height.width.equalTo(32)
        }
        weatherStack.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(12)
            $0.leading.equalTo(view).offset(16)
            $0.trailing.equalTo(settingsButton.snp.leading).inset(16)
        }
        weatherImageView.snp.makeConstraints {
            $0.leading.trailing.equalTo(view).inset(16)
            $0.height.equalTo(200)
            $0.top.equalTo(weatherStack.snp.bottom).offset(24)
        }
    }
    
    //MARK: - Logic
    private func showWeather() {
        cityLabel.text = savedCity
        
        UserDefaults.standard.set(savedCity, forKey: "city")
        
        guard let savedCity else { return }
        weatherNetworkManager.fetchWeather(for: savedCity) { [weak self] weather in
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
}
