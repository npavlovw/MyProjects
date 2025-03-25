//
//  SentTextViewController.swift
//  myProject
//
//  Created by Никита Павлов on 29.01.2025.
//

import UIKit

class SentTextViewController: UIViewController {

    @IBOutlet weak var sentText: UILabel!
    
    var receivedText: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sentText.text = receivedText
        
    }
    
}
