//
//  toDoViewController.swift
//  myProject
//
//  Created by Никита Павлов on 05.02.2025.
//

import UIKit

class toDoViewController: UIViewController, AddTaskDelegate {

    var tasks: [String] = []
    var filteredTasks: [String] = []
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var presentView: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        searchBar.delegate = self
        filteredTasks = tasks
    }
}


extension toDoViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredTasks = searchText.isEmpty ? tasks : filter(searchText)
        tableView.reloadData()
    }
    
    func filter (_ searchText: String) -> [String] {
        let result = tasks.filter({ $0.lowercased().contains(searchText.lowercased()) })
        return result
    }
    
}


extension toDoViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        filteredTasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = filteredTasks[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Мои задачи"
    }
    
}

extension toDoViewController: UITableViewDelegate {
    
    func didAddTask(_ task: String) {
        tasks.append(task)
        filteredTasks = tasks
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "toAddTask" {
                let destinationVC = segue.destination as! addTaskViewController
                destinationVC.delegate = self // Устанавливаем делегат
            }
        }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else {return}
        let deletedTask = filteredTasks[indexPath.row]
        if let index = tasks.firstIndex(of: deletedTask) {
            tasks.remove(at: index)
        }
        filteredTasks.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .left)
    }
}

// Протокол для передачи данных
protocol AddTaskDelegate: AnyObject {
    func didAddTask(_ task: String)
}
