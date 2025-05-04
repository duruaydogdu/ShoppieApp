import UIKit
import Kingfisher

class ProductDetailViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!

    // MARK: - Properties
    var viewModel: ProductDetailViewModel!

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    // MARK: - Setup
    private func setupUI() {
        titleLabel.text = viewModel.title
        priceLabel.text = viewModel.priceText
        quantityLabel.text = "\(viewModel.quantity)"
        totalLabel.text = viewModel.totalPriceText

        if let url = viewModel.imageURL {
            productImageView.kf.setImage(with: url)
        }
    }

    // MARK: - Actions
    @IBAction func increaseQuantityTapped(_ sender: UIButton) {
        viewModel.increaseQuantity()
        updateQuantityUI()
    }

    @IBAction func decreaseQuantityTapped(_ sender: UIButton) {
        viewModel.decreaseQuantity()
        updateQuantityUI()
    }

    @IBAction func addToCartTapped(_ sender: UIButton) {
        CartRepository.shared.addToCart(product: viewModel.product, quantity: viewModel.quantity) { success in
            DispatchQueue.main.async {
                let alert = UIAlertController(
                    title: success ? "Başarılı" : "Hata",
                    message: success ? "Ürün sepete eklendi" : "Ürün sepete eklenemedi",
                    preferredStyle: .alert
                )
                alert.addAction(UIAlertAction(title: "Tamam", style: .default))
                self.present(alert, animated: true)
            }
        }
    }


    // MARK: - Helpers
    private func updateQuantityUI() {
        quantityLabel.text = "\(viewModel.quantity)"
        totalLabel.text = viewModel.totalPriceText
    }
}
