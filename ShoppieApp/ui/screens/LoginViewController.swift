//
//  LoginViewController.swift
//  ShoppieApp
//
//  Created by Duru Aydoğdu on 2.05.2025.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

    @IBAction func loginTapped(_ sender: Any) {
        let username = usernameTextField.text ?? ""
               let password = passwordTextField.text ?? ""

               if UserRepository().login(username: username, password: password) {
                   goToMainTabBar()
               } else {
                   showAlert("Hatalı giriş.")
               }
    }
    
    func goToMainTabBar() {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let tabVC = storyboard.instantiateViewController(withIdentifier: "MainTabBarController")
            tabVC.modalPresentationStyle = .fullScreen
            present(tabVC, animated: true)
        }

        func showAlert(_ text: String) {
            let alert = UIAlertController(title: "Hata", message: text, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Tamam", style: .default))
            present(alert, animated: true)
        }

}
