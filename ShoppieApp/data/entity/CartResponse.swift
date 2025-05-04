//
//  CartResponse.swift
//  ShoppieApp
//
//  Created by Duru Aydoğdu on 2.05.2025.
//

import Foundation

struct CartResponse: Decodable {
    let urunler_sepeti: [CartItem]?
    let success: Int
}

