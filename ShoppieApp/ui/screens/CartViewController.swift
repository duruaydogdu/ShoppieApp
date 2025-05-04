import UIKit

class CartViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CartCellDelegate {

    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var totalPriceLabel: UILabel!

    // MARK: - Properties
    private let viewModel = CartViewModel()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        fetchCartItems()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchCartItems() // her gelişte sepeti güncelle
    }


    // MARK: - Setup
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        // Eğer hücre storyboard içinde tanımlıysa register etme
    }

    private func fetchCartItems() {
        viewModel.loadCartItems { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
                self?.updateTotal()
            }
        }
    }

    private func updateTotal() {
        let total = viewModel.totalAmount
        totalPriceLabel.text = "₺\(total)"
    }

    // MARK: - IBActions
    @IBAction func confirmCartButtonTapped(_ sender: UIButton) {
        print("Sepet onaylandı: ₺\(viewModel.totalAmount)")
    }

    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItems()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CartCell", for: indexPath) as? CartCell else {
            return UITableViewCell()
        }
        let item = viewModel.item(at: indexPath.row)
        cell.configure(with: item)
        cell.delegate = self // 💥 Silme butonunun çalışması için şart
        return cell
    }

    // MARK: - CartCellDelegate
    func didTapDeleteButton(on cell: CartCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }

        viewModel.removeItem(at: indexPath.row) { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
                self?.updateTotal()
            }
        }
    }
}
