//
//  CartPage.swift
//  SwiftUI_E-CommerceUI
//
//  Created by パクギョンソク on 2023/10/04.
//

import SwiftUI

struct CartPage: View {
    
    @EnvironmentObject var sharedData: SharedDataModel
    
    @State var showDeleteOption: Bool = false
    
    var body: some View {
        
        NavigationView {
            
            VStack(spacing: 10) {
                
                ScrollView(.vertical, showsIndicators: false) {
                    
                    VStack {
                        
                        HStack {
                            Text("Cart")
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
                            .opacity(sharedData.cartProducts.isEmpty ? 0 : 1)
                        }
                        .padding()
                        
                        if sharedData.cartProducts.isEmpty {
                            // EmptyView
                            emptyView
                        } else {
                            
                            VStack(spacing: 15) {
                                
                                ForEach($sharedData.cartProducts) { $product in
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
                                        CartView(product: $product)
                                    }
                                }
                            }
                            .padding()
                        }
                    }
                }
               
                // Checkoutボタンを表示
                if !sharedData.cartProducts.isEmpty {
                    Group {
                        HStack {
                            Text("Total")
                                .font(.custom(customFont, size: 14))
                                .fontWeight(.semibold)
                            
                            Spacer()
                            
                            Text(sharedData.getTotalPrice())
                                .font(.custom(customFont, size: 18).bold())
                                .foregroundColor(Color("Purple"))
                        }
                        
                        Button {
                            
                        } label: {
                            Text("Checkout")
                                .font(.custom(customFont, size: 18).bold())
                                .foregroundColor(.white)
                                .padding(.vertical, 18)
                                .frame(maxWidth: .infinity)
                                .background(Color("Purple"))
                                .cornerRadius(15)
                        }
                    }
                    .padding([.horizontal, .bottom], 20)
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
    
    func deleteProduct(product: Product) {
        if let index = sharedData.cartProducts.firstIndex(where: { $0.id == product.id }) {
            
            let _ = withAnimation {
                sharedData.cartProducts.remove(at: index)
            }
        }
    }
}

extension CartPage {
    
    var emptyView: some View {
        Group {
            Image("NoBasket")
                .resizable()
                .scaledToFit()
                .padding()
                .padding(.top, 35)
            
            Text("No Items added")
                .font(.custom(customFont, size: 25))
                .fontWeight(.semibold)
            
            Text("Hit the like button to save into Cart")
                .font(.custom(customFont, size: 18))
                .foregroundStyle(.gray)
                .multilineTextAlignment(.center)
                .padding()
        }
    }
}

struct CartView: View {
    
    @Binding var product: Product
    
    var body: some View {
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
                
                HStack(spacing: 10) {
                    Text("Quantity")
                        .font(.custom(customFont, size: 14))
                        .foregroundColor(.gray)
                    
                    Button {
                        product.quantity = (product.quantity > 0 ? product.quantity - 1 : 0)
                    } label: {
                        Image(systemName: "minus")
                            .font(.caption)
                            .foregroundColor(.white)
                            .frame(width: 20, height: 20)
                            .background(Color("Quantity"))
                            .cornerRadius(4)

                    }
                    
                    Text("\(product.quantity)")
                        .font(.custom(customFont, size: 14))
                        .fontWeight(.semibold)
                        .foregroundStyle(.black)
                    
                    Button {
                        product.quantity += 1
                    } label: {
                        Image(systemName: "plus")
                            .font(.caption)
                            .foregroundColor(.white)
                            .frame(width: 20, height: 20)
                            .background(Color("Quantity"))
                            .cornerRadius(4)

                    }
                }
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
}

#Preview {
    CartPage()
}
