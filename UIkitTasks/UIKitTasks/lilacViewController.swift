//
//  lilacViewController.swift
//  UIKitTasks
//
//  Created by Никита Павлов on 30.03.2025.
//

import UIKit

class lilacViewController: UIViewController {

    @IBOutlet weak var pushMeButton: UIButton!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var sliderValue: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        sliderValue.text = String(format: "%.2f", slider.value)
        pushMeButton.setTitle("push me", for: .normal)

    }

    @IBAction func showSliderValue(_ sender: UISlider) {
        sliderValue.text = String(format: "%.2f", slider.value)
    }
    
    @IBAction func showAlertController(_ sender: UIButton) {
        let alertController = UIAlertController(title: "new massege", message: "here you can see new massage", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "close", style: .default)
        alertController.addAction(action)
        
        present(alertController, animated: true)
    }
    
}
