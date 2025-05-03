//
//  APIResponse.swift
//  ShoppieApp
//
//  Created by Duru Aydoğdu on 2.05.2025.
//

import Foundation

struct APIResponse: Codable {
    let urunler: [Product]
    let success: Int
}

