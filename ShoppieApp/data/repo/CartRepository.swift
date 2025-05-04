import Foundation
import Alamofire

final class CartRepository {

    static let shared = CartRepository()
    private init() {}

    private var username: String {
        return UserRepository().getCurrentUsername() ?? "default_user"
    }

    // MARK: - Ürün Sepete Ekle (varsa adet artır)
    func addToCart(product: Product, quantity: Int, completion: @escaping (Bool) -> Void) {
        fetchCartItems { existingItems in
            if let existingItem = existingItems.first(where: { $0.ad == product.ad }) {
                // Önce sil, sonra yeni adetle ekle
                self.removeFromCart(sepetId: existingItem.sepetId) { removeSuccess in
                    if removeSuccess {
                        self.addNewCartItem(product: product, quantity: existingItem.siparisAdeti + quantity, completion: completion)
                    } else {
                        completion(false)
                    }
                }
            } else {
                self.addNewCartItem(product: product, quantity: quantity, completion: completion)
            }
        }
    }

    private func addNewCartItem(product: Product, quantity: Int, completion: @escaping (Bool) -> Void) {
        let url = "http://kasimadalan.pe.hu/urunler/sepeteUrunEkle.php"
        let parameters: Parameters = [
            "ad": product.ad,
            "resim": product.resim,
            "kategori": product.kategori,
            "fiyat": product.fiyat,
            "marka": product.marka,
            "siparisAdeti": quantity,
            "kullaniciAdi": username
        ]

        AF.request(url, method: .post, parameters: parameters).response { response in
            if let error = response.error {
                print("Add to cart failed: \(error.localizedDescription)")
                completion(false)
            } else {
                completion(true)
            }
        }
    }

    func fetchCartItems(completion: @escaping ([CartItem]) -> Void) {
        let url = "http://kasimadalan.pe.hu/urunler/sepettekiUrunleriGetir.php"
        let params: Parameters = ["kullaniciAdi": username]

        AF.request(url, method: .post, parameters: params)
            .validate()
            .responseDecodable(of: CartResponse.self) { response in
                switch response.result {
                case .success(let result):
                    completion(result.urunler_sepeti ?? [])
                case .failure(let error):
                    print("Fetch cart error: \(error.localizedDescription)")
                    completion([])
                }
            }
    }

    func removeFromCart(sepetId: Int, completion: @escaping (Bool) -> Void) {
        let url = "http://kasimadalan.pe.hu/urunler/sepettenUrunSil.php"
        let params: Parameters = [
            "sepetId": sepetId,
            "kullaniciAdi": username
        ]

        AF.request(url, method: .post, parameters: params).response { response in
            if let error = response.error {
                print("Remove from cart error: \(error.localizedDescription)")
                completion(false)
            } else {
                completion(true)
            }
        }
    }
}
