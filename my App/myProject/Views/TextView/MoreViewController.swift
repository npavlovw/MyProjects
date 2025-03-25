//
//  MoreViewController.swift
//  myProject
//
//  Created by Никита Павлов on 29.01.2025.
//

import UIKit

class MoreViewController: UIViewController {
    
    
    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func sendText(_ sender: UIButton) {
        performSegue(withIdentifier: "SentTextSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SentTextSegue" {
            let sentTextVC = segue.destination as! SentTextViewController
            sentTextVC.receivedText = textField.text
        }
    }
}

