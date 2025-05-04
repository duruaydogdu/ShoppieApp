//
//  CartProduct.swift
//  ShoppieApp
//
//  Created by Duru Aydoğdu on 2.05.2025.
//

import Foundation

struct CartItem: Codable {
    let sepetId: Int
    let ad: String
    let resim: String
    let kategori: String
    let fiyat: Int
    let marka: String
    let siparisAdeti: Int
    let kullaniciAdi: String
}


