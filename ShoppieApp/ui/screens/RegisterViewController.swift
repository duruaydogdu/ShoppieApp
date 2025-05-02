//
//  RegisterViewController.swift
//  ShoppieApp
//
//  Created by Duru Aydoğdu on 2.05.2025.
//

import UIKit

class RegisterViewController: UIViewController {
    
    // MARK: - IBOutlet
    @IBOutlet weak var registerLabel: UILabel!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var fullNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - IBAction
    @IBAction func registerTapped(_ sender: Any) {
        let username = usernameTextField.text ?? ""
        let fullName = fullNameTextField.text ?? ""
        let email = emailTextField.text ?? ""
        let phone = phoneTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        let confirmPassword = confirmPasswordTextField.text ?? ""

        // Boş alan kontrolü
        guard !username.isEmpty, !fullName.isEmpty, !email.isEmpty,
              !phone.isEmpty, !password.isEmpty, !confirmPassword.isEmpty else {
            showAlert("Lütfen tüm alanları doldurun.")
            return
        }

        // Şifre eşleşme kontrolü
        guard password == confirmPassword else {
            showAlert("Şifreler eşleşmiyor.")
            return
        }

        // Kayıt işlemi
        let user = User(username: username,
                        fullName: fullName,
                        email: email,
                        phone: phone,
                        password: password)

        if UserRepository().register(user: user) {
            goToMainTabBar()
        } else {
            showAlert("Bu kullanıcı adı zaten kayıtlı.")
        }
    }

    // MARK: - Yardımcı Fonksiyonlar
    private func goToMainTabBar() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let tabBarVC = storyboard.instantiateViewController(withIdentifier: "MainTabBarController")
        tabBarVC.modalPresentationStyle = .fullScreen
        present(tabBarVC, animated: true)
    }

    private func showAlert(_ message: String) {
        let alert = UIAlertController(title: "Uyarı", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Tamam", style: .default))
        present(alert, animated: true)
    }
}
