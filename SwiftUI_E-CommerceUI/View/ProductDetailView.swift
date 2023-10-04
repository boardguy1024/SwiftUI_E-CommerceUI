//
//  ProductDetailView.swift
//  SwiftUI_E-CommerceUI
//
//  Created by パクギョンソク on 2023/10/03.
//

import SwiftUI

struct ProductDetailView: View {
    
    var product: Product
    
    var animation: Namespace.ID
    
    @EnvironmentObject var sharedDataModel: SharedDataModel
    
    var body: some View {
        
        VStack {
            
            // Title Bar and Product Image.
            VStack {
                
                // Title Bar
                HStack {
                    Button {
                        // 詳細画面を閉じる
                        withAnimation(.easeInOut) {
                            sharedDataModel.showDetailProduct = false
                        }
                    } label: {
                        Image(systemName: "arrow.left")
                            .font(.title2)
                            .foregroundColor(.black.opacity(0.7))
                    }
                    
                    Spacer()
                    
                    Button {
                        addToLiked()
                    } label: {
                        Image("Liked")
                            .resizable()
                            .renderingMode(.template)
                            .scaledToFit()
                            .frame(width: 22, height: 22)
                            .foregroundColor(isLiked ? .red : .black.opacity(0.7))
                        
                    }
                }
                .padding()
                
                // Product Image
                Image(product.productImage)
                    .resizable()
                    .scaledToFit()
                    .matchedGeometryEffect(id: "\(product.id)\(sharedDataModel.fromSearchPage ? "SEARCH" : "IMAGE")", in: animation)
                    .padding(.horizontal)
                    .offset(y: -12)
                    .frame(maxHeight: .infinity)
            }
            .frame(height: getRect().height / 2.7)
            .zIndex(1) // transition時、ProductImageを表のLayerに配置させるため
            
            ScrollView(.vertical, showsIndicators: false) {
                
                // ProductData
                VStack(alignment: .leading, spacing: 15, content: {
                    Text(product.title)
                        .font(.custom(customFont, size: 20).bold())
                    
                    Text(product.subtitle)
                        .font(.custom(customFont, size: 18))
                        .foregroundColor(.gray)
                    
                    Text("Get Apple TV+ free for a year")
                        .font(.custom(customFont, size: 16).bold())
                        .padding(.top)
                    
                    Text("Available when you purchase any new iPhone, iPad, Mac or Apple TV, $5/month after free trial.")
                        .font(.custom(customFont, size: 15))
                        .foregroundColor(.gray)
                    
                    Button {
                        
                    } label: {
                        Label {
                            Image(systemName: "arrow.right")
                        } icon: {
                            Text("Full description")
                        }
                        .font(.custom(customFont, size: 15).bold())
                        .foregroundColor(Color("Purple"))
                    }
                    
                    HStack {
                        Text("Total")
                            .font(.custom(customFont, size: 17))
                        
                        Spacer()
                        
                        Text("\(product.price)")
                            .font(.custom(customFont, size: 20).bold())
                            .foregroundColor(Color("Purple"))
                    }
                    .padding(.vertical, 20)
                    
                    // Add Button
                    Button {
                        addToCart()
                    } label: {
                        Text("\(isAddedToCart ? "Added" : "Add") to Cart")
                            .font(.custom(customFont, size: 18).bold())
                            .foregroundColor(.white)
                            .padding(.vertical, 20)
                            .frame(maxWidth: .infinity)
                            .background(
                                Color("Purple")
                                    .cornerRadius(10)
                                    .shadow(color: .black.opacity(0.2), radius: 10)
                            )
                    }
                    
                })
                .padding([.horizontal, .bottom, .top], 25)
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                Color.white
                    .clipShape(CustomCorner(corner: [.topLeft, .topRight], cornerRadius: 25))
            )
            .zIndex(0)
        }
        .background(
            Color("HomeBG")
                .ignoresSafeArea()
        )
    }
    
    var isLiked: Bool {
        return sharedDataModel.likedProducts.contains { $0.id == product.id }
    }
    
    var isAddedToCart: Bool {
        return sharedDataModel.cartProducts.contains { $0.id == product.id }
    }
    
    func addToLiked() {
        
        if let index = sharedDataModel.likedProducts.firstIndex(where: { $0.id == product.id }) {
            // likedにproductがある場合には削除
            sharedDataModel.likedProducts.remove(at: index)
        } else {
            // likedに追加
            sharedDataModel.likedProducts.append(product)
        }
    }
    
    func addToCart() {
        if let index = sharedDataModel.cartProducts.firstIndex(where: { $0.id == product.id }) {
            sharedDataModel.cartProducts.remove(at: index)
        } else {
            sharedDataModel.cartProducts.append(product)
        }
    }
}

#Preview {
//    ProductDetailView(product: HomeViewModel().products[0])
//        .environmentObject(SharedDataModel())
    
    MainPage()
}
