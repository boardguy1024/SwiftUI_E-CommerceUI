//
//  MainPage.swift
//  SwiftUI_E-CommerceUI
//
//  Created by パクギョンソク on 2023/09/29.
//

import SwiftUI

enum TabType: String, CaseIterable {
    case home = "Home"
    case liked = "Liked"
    case profile = "Profile"
    case cart = "Cart"
}
struct MainPage: View {
    
    @State private var currentTab: TabType = .home
    
    @StateObject var sharedData: SharedDataModel = SharedDataModel()
    
    @Namespace var animation
    
    init() {
        // BottomにカスタムTabBarを設けるため、既存のものは非表示させる
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        
        VStack {
            TabView(selection: $currentTab,
                    content:  {
                Home(animation: animation)
                    .environmentObject(sharedData)
                    .tag(TabType.home)
                
                Text("Liked")
                    .tag(TabType.liked)
                
                ProfilePage()
                    .tag(TabType.profile)
                
                Text("Cart")
                    .tag(TabType.cart)
            })
            
            // CustomTabBar
            HStack(spacing: 0) {
                ForEach(TabType.allCases, id: \.self) { tab in
                    
                    Button {
                        currentTab = tab
                    } label: {
                        Image(tab.rawValue)
                            .resizable()
                            .renderingMode(.template)
                            .scaledToFit()
                            .frame(width: 22, height: 22)
                            .frame(maxWidth: .infinity)
                            .foregroundColor(currentTab == tab ? Color("Purple") : .gray.opacity(0.5))
                    }
                }
            }
            .padding(.horizontal)
            .padding(.bottom)
        }
        .background(Color("HomeBG"))
        .overlay(
            
            ZStack {
                // Show Detail Page
                if let product = sharedData.detailProduct, sharedData.showDetailProduct {
                    
                    ProductDetailView(product: product, animation: self.animation)
                        .environmentObject(self.sharedData)
                        .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .opacity))
                }
            }
        )
    }
}

#Preview {
    MainPage()
}
