//
//  Product.swift
//  ShoppieApp
//
//  Created by Duru Aydoğdu on 2.05.2025.
//

import Foundation

struct Product: Codable {
    let id: Int
    let ad: String
    let resim: String
    let kategori: String
    let fiyat: Int
    let marka: String
}

