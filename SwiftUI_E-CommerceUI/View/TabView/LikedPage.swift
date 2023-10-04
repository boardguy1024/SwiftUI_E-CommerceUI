//
//  LikedPage.swift
//  SwiftUI_E-CommerceUI
//
//  Created by パクギョンソク on 2023/10/04.
//

import SwiftUI

struct LikedPage: View {
    
    @EnvironmentObject var sharedData: SharedDataModel
    
    @State var showDeleteOption: Bool = false
    
    var body: some View {
        
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                
                VStack {
                    
                    HStack {
                        Text("Favorites")
                            .font(.custom(customFont, size: 28).bold())
                        
                        Spacer()
                        
                        Button {
                            withAnimation {
                                showDeleteOption.toggle()
                            }
                        } label: {
                            Image("Delete")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 25, height: 25)
                        }
                        .opacity(sharedData.likedProducts.isEmpty ? 0 : 1)
                    }
                    .padding()
                    
                    if sharedData.likedProducts.isEmpty {
                        // EmptyView
                        emptyView
                    } else {
                        
                        VStack(spacing: 15) {
                            
                            ForEach(sharedData.likedProducts) { product in
                                HStack(spacing: 0) {
                                    
                                    if showDeleteOption {
                                        Button {
                                            deleteProduct(product: product)
                                        } label: {
                                            Image(systemName: "minus.circle.fill")
                                                .font(.title2)
                                                .foregroundColor(.red)
                                        }
                                        .padding(.trailing)
                                    }
                                    CardView(product: product)
                                }
                            }
                        }
                        .padding()
                    }
                }
            }
            .navigationBarHidden(true)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                Color("HomeBG")
                    .ignoresSafeArea()
            )
        }
        .onDisappear {
            showDeleteOption = false
        }
    }
    
    @ViewBuilder
    func CardView(product: Product) -> some View {
        
        HStack(spacing: 15) {
            
            Image(product.productImage)
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
            
            VStack(alignment: .leading, spacing: 8) {
                Text(product.title)
                    .font(.custom(customFont, size: 18).bold())
                
                Text(product.subtitle)
                    .font(.custom(customFont, size: 17))
                    .fontWeight(.semibold)
                    .foregroundColor(.gray)
                
                Text("Type: \(product.type.rawValue)")
                    .font(.custom(customFont, size: 13))
                    .foregroundColor(.gray)
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 10)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            Color.white
                .cornerRadius(10)
        )
    }
    
    func deleteProduct(product: Product) {
        if let index = sharedData.likedProducts.firstIndex(where: { $0.id == product.id }) {
            
            let _ = withAnimation {
                sharedData.likedProducts.remove(at: index)
            }
        }
    }
}

extension LikedPage {
    
    var emptyView: some View {
        Group {
            Image("NoLiked")
                .resizable()
                .scaledToFit()
                .padding()
                .padding(.top, 35)
            
            Text("No favorites yet")
                .font(.custom(customFont, size: 25))
                .fontWeight(.semibold)
            
            Text("Hit the like button on each product page to save faborite ones")
                .font(.custom(customFont, size: 18))
                .foregroundStyle(.gray)
                .multilineTextAlignment(.center)
                .padding()
        }
    }
}

#Preview {
    LikedPage()
        .environmentObject(SharedDataModel())
}
