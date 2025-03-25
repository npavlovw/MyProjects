//
//  addTaskViewController.swift
//  myProject
//
//  Created by Никита Павлов on 05.02.2025.
//

import UIKit

class addTaskViewController: UIViewController {
    
    
    
    @IBOutlet weak var newTask: UITextField!
    weak var delegate: AddTaskDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func addButtonTupped(_ sender: UIButton) {
        guard let taskText = newTask.text, !taskText.isEmpty else {return}
        delegate?.didAddTask(taskText) // Передаем задачу через делегат
                dismiss(animated: true, completion: nil) // Закрываем экран
            }
}

