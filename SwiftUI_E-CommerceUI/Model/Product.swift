//
//  Product.swift
//  SwiftUI_E-CommerceUI
//
//  Created by パクギョンソク on 2023/09/29.
//

import Foundation

enum ProductType: String, CaseIterable {
    case wearable = "Wearable"
    case laptops = "Laptops"
    case phones = "Phones"
    case tablets = "Tablets"
}

struct Product: Identifiable, Hashable {
    var id = UUID().uuidString
    var type: ProductType
    var title: String
    var subtitle: String
    var description: String = ""
    var price: String
    var productImage: String = ""
    var quantity: Int = 1
}
