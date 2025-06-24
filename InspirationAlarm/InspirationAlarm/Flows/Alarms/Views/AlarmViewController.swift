//
//  ViewController.swift
//  InspirationAlarm
//
//  Created by Никита Павлов on 18.06.2025.
//

import UIKit
import SnapKit

class AlarmViewController: UIViewController {
    
    let viewModel = AlarmViewModel()
    let alarm = Alarm.setAlarms()
    
    //MARK: -UI-components
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero , style: .plain)
        tableView.frame = view.bounds
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .black
        tableView.register(AlarmCell.self, forCellReuseIdentifier: AlarmCell.reuseID)
        return tableView
    }()
 
    //MARK: -Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        setNavigationItem()
        setAppearance()
        setupTableView()
        
        viewModel.onSettingsScreenRequested = { [weak self] in
            let SettingsVC = SettingsViewController()
            let navController = UINavigationController(rootViewController: SettingsVC)
            navController.modalPresentationStyle = .automatic
            self?.present(navController, animated: true)
        }
    }
    
    private func setNavigationItem() {
        navigationItem.title = "Будильник"
        navigationItem.largeTitleDisplayMode = .automatic
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addButtonTapped)
        )
        navigationItem.rightBarButtonItem?.tintColor = .orange
    }

    private func setAppearance() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .black
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
    }
    
    //MARK: -Logics
    @objc private func addButtonTapped() {
        viewModel.presentSettingsVC()
    }
}

//MARK: -TableView
extension AlarmViewController:  UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        alarm.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: AlarmCell.reuseID, for: indexPath) as? AlarmCell {
            let alarm = alarm[indexPath.row]
            cell.setupCell(data: alarm)
            cell.backgroundColor = .black
            return cell
        }
        return UITableViewCell()
    }
}
