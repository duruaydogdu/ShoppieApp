//
//  CartRepository.swift
//  ShoppieApp
//
//  Created by Duru Aydoğdu on 4.05.2025.
//

import Foundation
import Alamofire

final class CartRepository {
    
    // MARK: - Singleton
    static let shared = CartRepository()
    private init() {}

    // MARK: - Sabit kullanıcı (test amaçlı)
    private let username = "duru_aydogdu" // TODO: Login sonrası dinamik yap

    // MARK: - Ürün Sepete Ekle
    func addToCart(product: Product, quantity: Int, completion: @escaping (Bool) -> Void) {
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
            if response.error == nil {
                completion(true)
            } else {
                print("Add to cart error: \(String(describing: response.error))")
                completion(false)
            }
        }
    }

    // MARK: - Sepetteki Ürünleri Getir
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


    // MARK: - Sepetten Ürün Sil
    func removeFromCart(sepetId: Int, completion: @escaping (Bool) -> Void) {
        let url = "http://kasimadalan.pe.hu/urunler/sepettenUrunSil.php"
        let params: Parameters = ["sepetId": sepetId, "kullaniciAdi": username]

        AF.request(url, method: .post, parameters: params).response { response in
            if response.error == nil {
                completion(true)
            } else {
                print("Remove from cart error: \(String(describing: response.error))")
                completion(false)
            }
        }
    }
}
