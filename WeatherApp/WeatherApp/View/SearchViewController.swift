//
//  ViewController.swift
//  WeatherApp
//
//  Created by Никита Павлов on 05.06.2025.
//

import UIKit
import SnapKit

class SearchViewController: UIViewController {
    
    private let viewModel = SearchViewModel()
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
        button.addTarget(self, action: #selector(searchWeather), for: .touchUpInside)
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
        setupConstraints()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
        searchCityBar.delegate = self
        searchCityBar.text = UserDefaults.standard.string(forKey: "city")
        checkSearchBar()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        UserDefaults.standard.set(searchCityBar.text, forKey: "city")
    }
    
    //MARK: - Constraints
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
    
    //MARK: - Logic
    private func checkSearchBar() {
        guard let text = searchCityBar.text, !text.isEmpty else { return }
        searchWeather()
    }
    
    @objc private func searchWeather() {
        guard let city = searchCityBar.text, !city.isEmpty else { return }
        let weatherVC = WeatherViewController()
        weatherVC.savedCity = searchCityBar.text ?? ""
        navigationController?.pushViewController(weatherVC, animated: true)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchWeather()
        searchBar.resignFirstResponder()
    }
}
