import UIKit
import Kingfisher

class HomeViewController: UIViewController, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    // MARK: - Outlets
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

        // Hücre kaydı gerekiyorsa buraya ekleyebilirsin
        // collectionView.register(UINib(nibName: "ProductCell", bundle: nil), forCellWithReuseIdentifier: "ProductCell")
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

    // MARK: - UISearchBarDelegate
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

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as? ProductCell else {
            return UICollectionViewCell()
        }

        let product = viewModel.product(at: indexPath.row)
        cell.configure(with: product)
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
