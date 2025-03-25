//
//  FullscreenViewController.swift
//  myProject
//
//  Created by Никита Павлов on 17.02.2025.
//

import UIKit

class FullscreenViewController: UIViewController {

    
    @IBOutlet weak var imageView: UIImageView!
    var selectedImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = selectedImage
        imageView.isUserInteractionEnabled = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(closeFullscreen))
        imageView.addGestureRecognizer(tapGesture)
        
        let swipeDownGesture = UISwipeGestureRecognizer(target: self, action: #selector(closeFullscreen))
        swipeDownGesture.direction = .down
        imageView.addGestureRecognizer(swipeDownGesture)
    }
    
    @objc func closeFullscreen(){
        dismiss(animated: true, completion: nil)
    }

}
