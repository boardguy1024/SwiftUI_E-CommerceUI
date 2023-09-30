//
//  MoreProductsView.swift
//  SwiftUI_E-CommerceUI
//
//  Created by パクギョンソク on 2023/09/29.
//

import SwiftUI

struct MoreProductsView: View {
    var body: some View {
        VStack {
            Text("More Products")
                .font(.custom(customFont, size: 24).bold())
                .foregroundStyle(.black)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading)
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .background(Color("HomeBG").ignoresSafeArea())
    }
}

#Preview {
    MoreProductsView()
}
