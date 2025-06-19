//
//  WeatherViewController.swift
//  WeatherApp
//
//  Created by Никита Павлов on 10.06.2025.
//

import UIKit
import SnapKit

final class WeatherViewController: UIViewController {
    
    private let viewModel: WeatherViewModel!
        
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
        label.text = viewModel.getCity()
        label.font = .systemFont(ofSize: 30, weight: .bold)
        return label
    }()
    
    private lazy var temperatureLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = .systemFont(ofSize: 80, weight: .medium)
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
        let stack = UIStackView(arrangedSubviews: [weatherLabel, feelsLikeLabel, pressureLabel, humidityLabel, windLabel])
        stack.axis = .vertical
        stack.spacing = 8
        stack.alignment = .leading
        return stack
    }()
    
    private lazy var weatherImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.isUserInteractionEnabled = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    init(viewModel: WeatherViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: -Lifycycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        viewModel.fetchData()
        setupConstraints()
        setupBindings()
    }
    
    //MARK: - Constraints
    private func setupConstraints() {
        view.addSubview(weatherImageView)
        weatherImageView.addSubview(temperatureLabel)
        weatherImageView.addSubview(cityLabel)
        weatherImageView.addSubview(weatherStack)
        weatherImageView.addSubview(settingsButton)
        
        weatherImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        weatherStack.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(16)
        }
        cityLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(weatherStack.snp.top).offset(-60)
        }
        temperatureLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(cityLabel.snp.top).offset(-12)
        }
        settingsButton.snp.makeConstraints {
            $0.top.equalTo(weatherStack.snp.top)
            $0.trailing.equalToSuperview().inset(12)
            $0.height.width.equalTo(26)
        }
    }
    
    //MARK: - Logic
    private func setupBindings() {
        viewModel.onDataUpdate = { [weak self] weather in
            DispatchQueue.main.async {
                self?.updateUI(with: weather)
            }
        }
        viewModel.onError = { [weak self] message in
            DispatchQueue.main.async {
                self?.showError(message)
            }
        }
        viewModel.temperatureText = { [weak self] temp in
            DispatchQueue.main.async {
                self?.temperatureLabel.text = temp
            }
        }
        viewModel.feelsLike = { [weak self] feelsLike in
            DispatchQueue.main.async {
                self?.feelsLikeLabel.text = "Ощущается как: \(feelsLike)"
            }
        }
    }
        
    private func updateUI(with weather: WeatherResponse) {
        setMainInfo(weather: weather)
        setDescription(weather: weather)
    }
    
    private func setMainInfo(weather: WeatherResponse) {
        viewModel.setTemperature(weather.main.temp)
        viewModel.setFeelsLikeTemperature(weather.main.feels_like)
        self.pressureLabel.text = viewModel.getPressure(weather.main.pressure)
        self.humidityLabel.text = viewModel.getHumidity(weather.main.humidity)
        self.windLabel.text = viewModel.getWindSpeed(weather.wind.speed)
    }
    
    private func setDescription(weather: WeatherResponse) {
        let weatherDescription = viewModel.getWeatherDescription(id: weather.weather.first?.id ?? 800)
        self.weatherLabel.text = weatherDescription.message
        self.weatherImageView.image = UIImage(named: weatherDescription.imageName)
        
        switch self.weatherImageView.image {
            case UIImage(named: "Дождь")?, UIImage(named: "Снег"):
            [self.cityLabel, self.temperatureLabel, self.weatherLabel,
             self.pressureLabel, self.humidityLabel, self.windLabel,
             self.feelsLikeLabel] .forEach {
                $0.textColor = .white
            }
            self.settingsButton.tintColor = .white
        case .none:
            print ("none")
        case .some(_):
            print ("some")
        }
    }
    
    private func showError(_ message: String) {
        let alert = UIAlertController(title: "Ошибка", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ок", style: .default))
            present(alert, animated: true)
    }
    
    @objc private func showTemperatureUnitAlert() {
        let alert = UIAlertController(
            title: "В каких единицах показывать температуру?",
            message: nil,
            preferredStyle: .alert
        )
        let celsiusAction = UIAlertAction(title: "Градусы Цельсия", style: .default) { [weak self] _ in
            self?.viewModel.setTemperatureUnit(.celsius)
            self?.viewModel.setFeelsLikeTemperatureUnit(.celsius)
        }
        let fahrenheitAction = UIAlertAction(title: "Градусы Фарентгейт", style: .default) { [weak self] _ in
            self?.viewModel.setTemperatureUnit(.fahrenheit)
            self?.viewModel.setFeelsLikeTemperatureUnit(.fahrenheit)
        }
        
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel)
        alert.addAction(celsiusAction)
        alert.addAction(fahrenheitAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
}
