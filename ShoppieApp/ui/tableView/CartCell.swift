import UIKit
import Kingfisher

protocol CartCellDelegate: AnyObject {
    func didTapDeleteButton(on cell: CartCell)
}

class CartCell: UITableViewCell {

    // MARK: - IBOutlets
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var unitPriceLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var deleteButton: UIButton!

    // MARK: - Delegate
    weak var delegate: CartCellDelegate?

    // MARK: - Configure
    func configure(with item: CartItem) {
        titleLabel.text = item.ad
        unitPriceLabel.text = "Fiyat: ₺\(item.fiyat)"
        quantityLabel.text = "Adet: \(item.siparisAdeti)"
        totalLabel.text = "₺\(item.fiyat * item.siparisAdeti)"

        if let url = URL(string: "http://kasimadalan.pe.hu/urunler/resimler/\(item.resim)") {
            productImageView.kf.setImage(with: url)
        }

        containerView.layer.cornerRadius = 10
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOpacity = 0.08
        containerView.layer.shadowOffset = CGSize(width: 0, height: 2)
        containerView.layer.shadowRadius = 4
        containerView.layer.masksToBounds = false
    }

    // MARK: - Actions
    @IBAction func deleteButtonTapped(_ sender: UIButton) {
        delegate?.didTapDeleteButton(on: self)
    }
}
