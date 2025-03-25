//
//  settingsViewController.swift
//  myProject
//
//  Created by Никита Павлов on 28.01.2025.
//

import UIKit

class settingsViewController: UIViewController {
    
    
    
    @IBOutlet weak var VolumeValue: UILabel!
    @IBOutlet weak var BrightnessValue: UILabel!
    
    @IBOutlet weak var BrightnessSlider: UISlider!
    @IBOutlet weak var VolumeSlider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        BrightnessValue.text = "\(Int(BrightnessSlider.value))"
        VolumeValue.text = "\(Int(VolumeSlider.value))"
    }
    
    @IBAction func BrightnessChanged(_ sender: UISlider) {
        BrightnessValue.text = "\(Int(sender.value))"
    }
    
    @IBAction func VolumeChanged(_ sender: UISlider) {
        VolumeValue.text = "\(Int(sender.value))"

    }
}
