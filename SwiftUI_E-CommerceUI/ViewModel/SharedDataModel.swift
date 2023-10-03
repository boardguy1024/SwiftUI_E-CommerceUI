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
    
}
