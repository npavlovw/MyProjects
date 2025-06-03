//
//  HomeViewController.swift
//  FoodDeliveryApp
//
//  Created by Никита Павлов on 24.04.2025.
//

import UIKit
import SnapKit

class HomeViewController: UIViewController, UISearchBarDelegate {
    
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
    private lazy var basketButton = CustomButton(target: self, action: #selector(basketButtonTapped), backgroundColor: .logInBackground, image: UIImage(named: "Icon")!)
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
    private lazy var greetingLabel: UILabel = {
        let normalText = "Hey Halal, "
        let boldText = "Good Afternoon"
        let attributedText = NSMutableAttributedString(
            string: normalText,
            attributes: [.font: UIFont.systemFont(ofSize: 16)]
        )
        let boldPart = NSAttributedString(
            string: boldText,
            attributes: [.font: UIFont.boldSystemFont(ofSize: 16)]
        )
        attributedText.append(boldPart)
        
        $0.attributedText = attributedText
        $0.textAlignment = .left
        return $0
    }(UILabel())
    private lazy var searchBar: UISearchBar = {
        $0.placeholder = "Search dishes, restaurants"
        $0.searchBarStyle = .minimal
        $0.delegate = self
        return $0
    }(UISearchBar())
    var allCategories = AllCategories.mockData()
    private lazy var allCategoriesLabel = AllCategoriesView(target: self, action: #selector(seeAllCategoriesTapped), title: "All Categories")
    let layoutAllCategories: UICollectionViewFlowLayout = {
        $0.scrollDirection = .horizontal
        $0.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        $0.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
        return $0
    }(UICollectionViewFlowLayout())
    private lazy var allCategoriesCollectionView: UICollectionView = {
        $0.register(AllCategoriesCell.self, forCellWithReuseIdentifier: AllCategoriesCell.reuseID)
        $0.showsHorizontalScrollIndicator = false
        $0.delegate = self
        $0.dataSource = self
        $0.contentInset = .zero
        return $0
    }(UICollectionView(frame: .zero, collectionViewLayout: layoutAllCategories))
    private lazy var openRestaurantsLabel = AllCategoriesView(target: self, action: #selector(seeAllRestaurantsTapped), title: "Open Restaurants")
    var allRestaurants = AllRestaurants.mockData()
    let layoutRestourants: UICollectionViewFlowLayout = {
        $0.scrollDirection = .vertical
        $0.minimumLineSpacing = 25
        $0.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        return $0
    }(UICollectionViewFlowLayout())
    private lazy var openRestaurantsCollectionView: UICollectionView = {
        $0.register(OpenRestaurantsCell.self, forCellWithReuseIdentifier: OpenRestaurantsCell.reuseID)
        $0.showsVerticalScrollIndicator = false
        $0.delegate = self
        $0.dataSource = self
        $0.contentInset = .zero
        return $0
    }(UICollectionView(frame: .zero, collectionViewLayout: layoutRestourants))
    
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height

    //MARK: -Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setConstraints()
        setupKeyboardDismissGesture()
    }
    
    //MARK: -Constraints
    private func setConstraints() {
        [menuButton, deliverToLabel, locationStack, basketButton, greetingLabel,searchBar, allCategoriesLabel, allCategoriesCollectionView, openRestaurantsLabel, openRestaurantsCollectionView].forEach {
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
        greetingLabel.snp.makeConstraints { make in
            make.top.equalTo(menuButton.snp.bottom).offset(24)
            make.leading.trailing.equalToSuperview().inset(24)
        }
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(greetingLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(62)
        }
        allCategoriesLabel.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(16)
            make.leading.equalTo(greetingLabel.snp.leading)
            make.trailing.equalTo(greetingLabel.snp.trailing)
            make.height.equalTo(24)
        }
        allCategoriesCollectionView.snp.makeConstraints { make in
            make.top.equalTo(allCategoriesLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(60)
        }
        openRestaurantsLabel.snp.makeConstraints { make in
            make.top.equalTo(allCategoriesCollectionView.snp.bottom).offset(16)
            make.leading.equalTo(greetingLabel.snp.leading)
            make.trailing.equalTo(greetingLabel.snp.trailing)
            make.height.equalTo(24)
        }
        openRestaurantsCollectionView.snp.makeConstraints { make in
            make.top.equalTo(openRestaurantsLabel.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(24)
            make.bottom.equalTo(view.snp.bottom)
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
                                                            
    @objc private func seeAllCategoriesTapped() {
        print("See All Categories Tapped")
    }
    
    @objc private func seeAllRestaurantsTapped() {
        print("See All Restaurants Tapped")
    }

    //Что происходит при вводе текста в SearchBar
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    }
    
    //MARK: -Keyboard
    private func setupKeyboardDismissGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func hideKeyboard() {
        view.endEditing(true)
    }
}

//MARK: -DataSource
extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == allCategoriesCollectionView {
            return allCategories.count
        } else if collectionView == openRestaurantsCollectionView {
            return allRestaurants.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == allCategoriesCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AllCategoriesCell.reuseID, for: indexPath) as! AllCategoriesCell
            cell.configure(with: allCategories[indexPath.item])
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OpenRestaurantsCell.reuseID, for: indexPath) as! OpenRestaurantsCell
            cell.configure(with: allRestaurants[indexPath.item])
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == allCategoriesCollectionView {
            for i in 0..<allCategories.count {
                allCategories[i].isSelected = (i == indexPath.item)
            }
            collectionView.reloadData()
        } else {
            for i in 0..<allRestaurants.count {
                allRestaurants[i].isSelected = (i == indexPath.item)
            }
            collectionView.reloadData()
        }
    }
}

//MARK: -Delegate
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
}
