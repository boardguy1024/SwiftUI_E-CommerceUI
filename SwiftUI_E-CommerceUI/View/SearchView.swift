//
//  SearchView.swift
//  SwiftUI_E-CommerceUI
//
//  Created by パクギョンソク on 2023/09/30.
//

import SwiftUI

struct SearchView: View {
    
    var animation: Namespace.ID
    
    @EnvironmentObject var homeViewModel: HomeViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            
            HStack(spacing: 20) {
                
                // BackButton
                Button {
                    withAnimation {
                        homeViewModel.searchActivate = false
                    }
                    // searchTextを初期化
                    homeViewModel.searchText = ""
                } label: {
                    Image(systemName: "arrow.left")
                        .font(.title2)
                        .foregroundColor(.black.opacity(0.7))
                }
                
                // SearchBar
                HStack(spacing: 15) {
                    Image(systemName: "magnifyingglass")
                        .font(.title)
                        .foregroundColor(.gray)
                    
                    TextField("Search", text: $homeViewModel.searchText)
                        .textCase(.lowercase)
                }
                .padding(.vertical, 12)
                .padding(.horizontal)
                .background(
                    Capsule()
                        .strokeBorder(Color("Purple"), lineWidth: 1)
                )
                .matchedGeometryEffect(id: "SEARCHBAR", in: animation)
                .padding(.trailing, 20)
                
            }
            .padding([.horizontal, .top])
            .padding(.bottom, 10)
            
            if let products = homeViewModel.searchedProducts {
                
                // Empty View
                if products.isEmpty {
                    VStack(spacing: 10) {
                        Image("NotFound")
                            .resizable()
                            .scaledToFit()
                            .padding(.top, 60)
                        
                        Text("Item Not Found")
                            .font(.custom(customFont, size: 22).bold())
                        Text("Try a more generic search term or try looking for alternative products.")
                            .font(.custom(customFont, size: 16))
                            .foregroundStyle(.gray)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                    }
                    .padding()
                } else {
                    
                    // Filter Results
                    ScrollView(.vertical, showsIndicators: false) {
                        
                        VStack(spacing: 0) {
                            
                            Text("Found \(products.count) results")
                                .font(.custom(customFont, size: 24).bold())
                                .padding(.vertical)
                           
                            StaggeredGrid(columns: 2, spacing: 20, list: products) { product in
                                // CardView
                                ProductCardView(product: product)
                            }
                        }
                        
                        
                     
                    }
                    .padding()
                }
                
            } else {
                ProgressView()
                    .padding(.top, 30)
                    .opacity(homeViewModel.searchText == "" ? 0 : 1)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(Color("HomeBG").ignoresSafeArea())
    }
    
    @ViewBuilder
    func ProductCardView(product: Product) -> some View {
        VStack(spacing: 10) {
            Image(product.productImage)
                .resizable()
                .scaledToFit()
                .frame(width: getRect().width / 3, height: getRect().width / 2.5)
                
                // 画像を上半分表示するため (-80分 .topPadding +80する必要がある)
                .offset(y: -50)
                .padding(.bottom, -60)
            
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
        .padding(.top, 50)
    }
}

#Preview {
    Home()
}
