import UIKit
import Kingfisher

class HomeViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!

    // MARK: - Properties
    private let viewModel = HomeViewModel()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupSearchBar()
        fetchData()
    }

    // MARK: - Setup
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    private func setupSearchBar() {
        searchBar.delegate = self
    }

    // MARK: - Data Fetching
    private func fetchData() {
        viewModel.loadProducts { [weak self] in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
    }

    // MARK: - Navigation
    func navigateToDetail(with product: Product) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let detailVC = storyboard.instantiateViewController(withIdentifier: "ProductDetailViewController") as? ProductDetailViewController {
            detailVC.viewModel = ProductDetailViewModel(product: product)
            navigationController?.pushViewController(detailVC, animated: true)
        }
    }
}

// MARK: - UISearchBarDelegate
extension HomeViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.search(query: searchText)
        collectionView.reloadData()
    }
}

// MARK: - UICollectionViewDataSource
extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItems()
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as? ProductCell else {
            return UICollectionViewCell()
        }

        let product = viewModel.product(at: indexPath.row)
        cell.configure(with: product)
        cell.delegate = self
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let spacing: CGFloat = 12
        let width = (collectionView.frame.width - spacing * 3) / 2
        return CGSize(width: width, height: 220)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }
}

// MARK: - UICollectionViewDelegate
extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let product = viewModel.product(at: indexPath.row)
        navigateToDetail(with: product)
    }
}

// MARK: - ProductCellDelegate
extension HomeViewController: ProductCellDelegate {
    func didTapAddToCart(product: Product) {
        CartRepository.shared.addToCart(product: product, quantity: 1) { success in
            DispatchQueue.main.async {
                let alert = UIAlertController(
                    title: success ? "Başarılı" : "Hata",
                    message: success ? "\(product.ad) sepete eklendi" : "Ürün sepete eklenemedi",
                    preferredStyle: .alert
                )
                alert.addAction(UIAlertAction(title: "Tamam", style: .default))
                self.present(alert, animated: true)
            }
        }
    }
}
