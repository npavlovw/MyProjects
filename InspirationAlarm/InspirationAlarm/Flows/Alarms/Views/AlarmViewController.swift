//
//  ViewController.swift
//  InspirationAlarm
//
//  Created by Никита Павлов on 18.06.2025.
//

import UIKit
import SnapKit

class AlarmViewController: UIViewController {
    
    let alarmTableViewCell = AlarmCell()
    var alarmClocks: [Int] = [1, 2, 3, 4, 5]
    
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
        setupTableView()
        setAppearance()
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
    }

}

//MARK: -TableView
extension AlarmViewController:  UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        alarmClocks.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AlarmCell.reuseID, for: indexPath)
        cell.textLabel?.text = "\(indexPath.row + 1)"
        return cell
    }
}
