//
//  TabBarViewController.swift
//  myProject
//
//  Created by Никита Павлов on 28.01.2025.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    private var isLoggedIn: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if !isLoggedIn {
            showLogin()
            isLoggedIn = true
        }
    }
    
    private func showLogin() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let loginViewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController")
        loginViewController.modalPresentationStyle = .fullScreen
        present(loginViewController, animated: true)
    }
}
