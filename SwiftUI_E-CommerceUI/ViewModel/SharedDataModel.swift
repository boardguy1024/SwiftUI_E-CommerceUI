//
//  SharedDataModel.swift
//  SwiftUI_E-CommerceUI
//
//  Created by パクギョンソク on 2023/10/03.
//

import Foundation

class SharedDataModel: ObservableObject {
    
    @Published var detailProduct: Product?
    @Published var showDetailProduct: Bool = false
    
    // matchedGeometry animationのidを切り替えるために使う手段
    // このProjectでは不要だが、同じ画面に複数のidでanimationを行う際に使うと良い
    @Published var fromSearchPage: Bool = false
    
    @Published var likedProducts: [Product] = []
    @Published var cartProducts: [Product] = []
        
    func getTotalPrice() -> String {
        
        var total: Int = 0
        
        cartProducts.forEach { product in
            let price = product.price.replacingOccurrences(of: "$", with: "") as NSString
            let quantity = product.quantity
            let priceTotal = quantity * price.integerValue
            
            total += priceTotal
        }
        return "$\(total)"
    }
}
