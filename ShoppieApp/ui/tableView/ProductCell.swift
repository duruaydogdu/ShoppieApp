import UIKit
import Kingfisher

class ProductCell: UICollectionViewCell {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var addToCartButton: UIButton!
    
    func configure(with product: Product) {
        titleLabel.text = product.ad
        priceLabel.text = "₺\(product.fiyat)"
        
        if let url = URL(string: "http://kasimadalan.pe.hu/urunler/resimler/\(product.resim)") {
            imageView.kf.setImage(with: url)
        }

        containerView.layer.cornerRadius = 12
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOpacity = 0.08
        containerView.layer.shadowOffset = CGSize(width: 0, height: 2)
        containerView.layer.shadowRadius = 4
        containerView.layer.masksToBounds = false
    }
}
