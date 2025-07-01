//
//  ViewController.swift
//  InspirationAlarm
//
//  Created by Никита Павлов on 18.06.2025.
//

import UIKit
import SnapKit
import UserNotifications

class AlarmViewController: UIViewController {
    
    var viewModel: AlarmViewModel
        
    init(viewModel: AlarmViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        setupBindings()
        setupNotification()
        
        viewModel.showSavedAlarms()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewModel.saveAlarmsForExit()
    }

    private func setNavigationItem() {
        navigationItem.title = "Будильник"
        navigationItem.largeTitleDisplayMode = .automatic
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addAlarm)
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
    
    private func setupNotification() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if granted {
                print("✅ Разрешение получено")
            } else {
                print("❌ Разрешение не получено")
            }
        }
    }
    
    private func setupBindings() {
        viewModel.onAlarmsUpdated = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    //MARK: -Logics
    @objc private func addAlarm() {
         viewModel.showSettingsScreen()
    }
}

//MARK: -TableView
extension AlarmViewController:  UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.viewModel.getAlarms().count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: AlarmCell.reuseID, for: indexPath) as? AlarmCell {
            let alarm = self.viewModel.getAlarms()[indexPath.row]
            cell.setupCell(data: alarm)
            cell.onSwitchToggled = { [weak self] isOn in
                self?.viewModel.checkSwitch(isOn: isOn, at: indexPath.row)
            }
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Удалить") { [weak self] (_, _, completionHandler) in
                self?.viewModel.deleteAlarm(at: indexPath.row)
                completionHandler(true)
            }
            return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}
