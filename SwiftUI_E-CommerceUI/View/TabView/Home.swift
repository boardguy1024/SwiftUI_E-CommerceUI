//
//  Home.swift
//  SwiftUI_E-CommerceUI
//
//  Created by パクギョンソク on 2023/09/29.
//

import SwiftUI

struct Home: View {
    
    @Namespace var animation
    @StateObject var viewModel = HomeViewModel()
    
    var body: some View {
        
        ScrollView(.vertical, showsIndicators: false) {
            
            VStack(spacing: 15) {
                
                // Search Bar
                ZStack {
                    if viewModel.searchActivate {
                        SearchBar()
                    } else {
                        SearchBar()
                            .matchedGeometryEffect(id: "SEARCHBAR", in: animation)
                    }
                }
                .frame(width: getRect().width / 1.6)
                .padding(.horizontal, 25)
                .onTapGesture {
                    withAnimation {
                        viewModel.searchActivate = true
                    }
                }
    
                Text("Order online\ncollect in store")
                    .font(.custom(customFont, size: 28).bold())
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top)
                    .padding(.horizontal, 25)
                
                // ProductType
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 18) {
                        ForEach(ProductType.allCases, id: \.self) { product in
                            ProductTypeView(type: product)
                        }
                    }
                    .padding(.horizontal, 25)
                }
                .padding(.top, 25)
                
                // Product Pages
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 25) {
                        ForEach(viewModel.filteredProducts) { product in
                            ProductCardView(product: product)
                        }
                    }
                    .padding(.horizontal, 25)
                }
                .padding(.top, 30)
                
            }
            .padding(.vertical)
            
            // See More Button
            Button {
                viewModel.showMoreProducts.toggle()
            } label: {
                Label {
                    Image(systemName: "arrow.right")
                } icon: {
                    Text("see more")
                }
                .font(.custom(customFont, size: 15).bold())
                .foregroundColor(Color("Purple"))
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding([.top, .trailing])
            }
        }
        .background(Color("HomeBG"))
        .onChange(of: viewModel.currentProductType) {
            viewModel.filterProductByType()
        }
        .sheet(isPresented: $viewModel.showMoreProducts, content: {
            MoreProductsView()
        })
        .overlay(
            ZStack {
                if viewModel.searchActivate {
                    SearchView(animation: self.animation)
                        .environmentObject(self.viewModel)
                }
            }
        )
    }
    
    @ViewBuilder
    func ProductCardView(product: Product) -> some View {
        VStack(spacing: 10) {
            Image(product.productImage)
                .resizable()
                .scaledToFit()
                .frame(width: getRect().width / 2.5, height: getRect().width / 2.5)
                
                // 画像を上半分表示するため (-80分 .topPadding +80する必要がある)
                .offset(y: -80)
                .padding(.bottom, -80)
            
            Text(product.title)
                .font(.custom(customFont, size: 18))
                .fontWeight(.semibold)
                .padding(.top)
            
            Text(product.subtitle)
                .font(.custom(customFont, size: 14))
                .foregroundStyle(.gray)
            
            Text(product.price)
                .font(.custom(customFont, size: 16))
                .fontWeight(.bold)
                .foregroundStyle(Color("Purple"))
                .padding(.top, 5)
        }
        .padding(.horizontal, 20)
        .padding(.bottom, 22)
        .background(
            Color.white
                .cornerRadius(25)
        )
        // 画像を上半分表示するため (+80する必要がある)
        .padding(.top, 80)
    }
    
    @ViewBuilder
    func SearchBar() -> some View {
        HStack(spacing: 15) {
            Image(systemName: "magnifyingglass")
                .font(.title)
                .foregroundColor(.gray)
            
            TextField("Search", text: .constant(""))
                // TextFiled.desabledした状態で onTapGestureを反応させる方法
                .background(Color("HomeBG"))
                .disabled(true)
        }
        .padding(.vertical, 12)
        .padding(.horizontal)
        .overlay(
            Capsule()
                .strokeBorder(Color.gray, lineWidth: 1)
        )
        
    }
    
    @ViewBuilder
    func ProductTypeView(type: ProductType) -> some View {
        
        Button {
            withAnimation {
                viewModel.currentProductType = type
            }
        } label: {
            Text(type.rawValue)
                .font(.custom(customFont, size: 15))
                .fontWeight(.semibold)
                .foregroundStyle(viewModel.currentProductType == type ? Color("Purple") : .gray)
                .padding(.vertical, 8)
                .overlay(
                    ZStack {
                        if viewModel.currentProductType == type {
                            Capsule()
                                .fill(Color("Purple"))
                                .frame(height: 2)
                                .matchedGeometryEffect(id: "PRODUCT_TAB", in: animation)
                        }
                    }
                    , alignment: .bottom)
        }
    }
}

#Preview {
    Home()
}
