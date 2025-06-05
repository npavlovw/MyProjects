//
//  AdressesViewController.swift
//  FoodDeliveryApp
//
//  Created by Никита Павлов on 01.05.2025.
//

import UIKit
import SnapKit

class AdressesViewController: UIViewController, UIGestureRecognizerDelegate {
    
    //MARK: UI-Components
    private lazy var backButton = BackButton(target: self, action: #selector(backToProfileVC), backgroundColor: (UIColor(named: "btnGray") ?? .gray))
    private lazy var label: UILabel = {
        $0.text = "My Address"
        $0.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        $0.textColor = .black
        $0.snp.makeConstraints { make in
            make.width.equalTo(100)
        }
        return $0
    }(UILabel())
    private lazy var navBarStackView: UIStackView = {
        $0.axis = .horizontal
        $0.distribution = .fill
        $0.spacing = 16
        return $0
    }(UIStackView(arrangedSubviews: [backButton, label]))
    private lazy var tableView: UITableView = {
        $0.dataSource = self
        $0.register(AdressCell.self, forCellReuseIdentifier: AdressCell.reuseID)
        $0.separatorStyle = .none
        return $0
    }(UITableView(frame: .zero, style: .plain))
    let adresses = Adresses.makeAdresses()
    private lazy var addAdressButton = MainButton(textButton: "ADD NEW ADRESS", target: self, action: #selector(addAdressTupped))
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        self.navigationItem.hidesBackButton = true
        self.navigationController?.navigationBar.isHidden = true
        
        makeConstraints()

    }
    
    //MARK: Constraints
    private func makeConstraints() {
        view.addSubview(navBarStackView)
        view.addSubview(tableView)
        view.addSubview(addAdressButton)
        
        navBarStackView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.equalToSuperview().offset(24)
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(navBarStackView.snp.bottom).offset(24)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(addAdressButton.snp.top).inset(24)
        }
        addAdressButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(24)
            make.bottom.equalToSuperview().inset(30)
        }
    }
    
    //MARK: Logics
    @objc private func backToProfileVC() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func addAdressTupped() {
        print("Add adress tapped")
    }
}

extension AdressesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        adresses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // TODO: - guard
        if let cell = tableView.dequeueReusableCell(withIdentifier: AdressCell.reuseID, for: indexPath) as? AdressCell {
            let adress = adresses[indexPath.row]
            cell.setupCell(adress: adress)
            cell.selectionStyle = .none
            return cell
        }
        return UITableViewCell()
    }
}

