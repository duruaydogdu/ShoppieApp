import Foundation

final class ProductDetailViewModel {
    
    // MARK: - Properties
    let product: Product
    var quantity: Int = 1

    // MARK: - Init
    init(product: Product) {
        self.product = product
    }

    // MARK: - Computed Properties
    var title: String {
        return product.ad
    }

    var priceText: String {
        return "₺\(product.fiyat)"
    }

    var totalPriceText: String {
        let total = product.fiyat * quantity
        return "₺\(total)"
    }

    var imageURL: URL? {
        // Görsel URL’si sunucudan geldiyse doğru yolu ver
        return URL(string: "http://kasimadalan.pe.hu/urunler/resimler/\(product.resim)")
    }

    var productID: Int {
        return product.id
    }

    var unitPrice: Int {
        return product.fiyat
    }

    // MARK: - Quantity Operations
    func increaseQuantity() {
        quantity += 1
    }

    func decreaseQuantity() {
        quantity = max(1, quantity - 1)
    }
}
