//
//  EntranceViewController.swift
//  ShoppieApp
//
//  Created by Duru Aydoğdu on 2.05.2025.
//

import UIKit

class EntranceViewController: UIViewController {
    
    @IBOutlet weak var entranceImage: UIImageView!
    
    @IBOutlet weak var entranceLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func registerButton(_ sender: Any) {
        performSegue(withIdentifier: "toRegister", sender: nil)
    }
    
    @IBAction func loginButton(_ sender: Any) {
        performSegue(withIdentifier: "toLogin", sender: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let _ = UserRepository().getCurrentUsername() {
            showMainTabBar()
        }
    }
    
    func showMainTabBar() {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let tabVC = storyboard.instantiateViewController(withIdentifier: "MainTabBarController")
            tabVC.modalPresentationStyle = .fullScreen
            present(tabVC, animated: true)
        }
    
}
