import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    
    private let userRepo = UserRepository()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupProfile()
        
        if let user = UserRepository().getCurrentUser() {
              fullNameLabel.text = user.fullName
              emailLabel.text = user.email
              phoneLabel.text = user.phone
              usernameLabel.text = user.username
          }
    
    }
    
    private func setupProfile() {
        guard let user = userRepo.getCurrentUser() else {
            showAlert("Giriş yapılmamış.")
            return
        }

        usernameLabel.text = "Kullanıcı adı: \(user.username)"
        fullNameLabel.text = "Ad Soyad: \(user.fullName)"
        emailLabel.text = "E-posta: \(user.email)"
        phoneLabel.text = "Telefon: \(user.phone)"
    }

    private func showAlert(_ message: String) {
        let alert = UIAlertController(title: "Bilgi", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Tamam", style: .default))
        present(alert, animated: true)
    }
}
