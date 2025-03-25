//
//  gameViewController.swift
//  myProject
//
//  Created by Никита Павлов on 26.02.2025.
//

import UIKit

class gameViewController: UIViewController {

    @IBOutlet weak var mainDetail: UIView!
    var clipsToBounds = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Добавляем распознавание нажатий
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(moveView))
        mainDetail.addGestureRecognizer(tapGesture)

    }
    
    @objc private func moveView() {
            // Вычисляем случайные координаты в пределах экрана
            let maxX = view.bounds.width - mainDetail.frame.width
            let maxY = view.bounds.height - mainDetail.frame.height - 100
            let randomX = CGFloat.random(in: 0...maxX)
            let randomY = CGFloat.random(in: 30...maxY)
            
            // Анимируем перемещение
                UIView.animate(withDuration: 0.3, delay: 0, options: .curveLinear , animations: {
                self.mainDetail.frame.origin = CGPoint(x: randomX, y: randomY)
            })
        }
}
