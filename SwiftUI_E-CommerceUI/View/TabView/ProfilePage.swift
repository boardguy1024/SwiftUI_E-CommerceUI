//
//  ProfilePage.swift
//  SwiftUI_E-CommerceUI
//
//  Created by パクギョンソク on 2023/10/02.
//

import SwiftUI

struct ProfilePage: View {
    var body: some View {
        
        NavigationView {
            
            ScrollView(.vertical, showsIndicators: false) {
                
                VStack {
                    
                    Text("My Profile")
                        .font(.custom(customFont, size: 28).bold())
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    
                    VStack(spacing: 15) {
                        Image("elon")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 60, height: 60)
                            .clipShape(Circle())
                        
                        Text("Elon Musk")
                            .font(.custom(customFont, size: 16))
                            .fontWeight(.semibold)
                        
                        HStack(alignment: .top, spacing: 10) {
                            Image(systemName: "location.north.circle.fill")
                                .foregroundColor(.gray)
                                .rotationEffect(.init(degrees: 180))
                            
                            Text("Address: \nCorporate Secretary Tesla, Inc. 1 \nTesla Road Austin, \nTX 78725. United States.")
                                .font(.custom(customFont, size: 15))
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .padding(.top, -30)
                    .padding(.horizontal)
                    .padding(.bottom)
                    .background(
                        Color.white
                            .cornerRadius(15)
                    )
                    .padding()
                    .padding(.vertical, 20)
                                        
                    CustomNavigationLink(title: "Edit Profile") {
                        //遷移先のViewを設定
                        Text("Hello!!")
                            .navigationTitle("Edit Profile")
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background(
                                Color("HomeBG").ignoresSafeArea()
                            )
                    }
                    
                    CustomNavigationLink(title: "Shopping address") {
                        //遷移先のViewを設定
                        Text("Hello!!")
                            .navigationTitle("Shopping address")
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background(
                                Color("HomeBG").ignoresSafeArea()
                            )
                    }
                    
                    CustomNavigationLink(title: "Order history") {
                        //遷移先のViewを設定
                        Text("Hello!!")
                            .navigationTitle("Order history")
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background(
                                Color("HomeBG").ignoresSafeArea()
                            )
                    }
                    
                    CustomNavigationLink(title: "Cards") {
                        //遷移先のViewを設定
                        Text("Hello!!")
                            .navigationTitle("Cards")
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background(
                                Color("HomeBG").ignoresSafeArea()
                            )
                    }
                    
                    CustomNavigationLink(title: "Notifications") {
                        //遷移先のViewを設定
                        Text("Hello!!")
                            .navigationTitle("Notifications")
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background(
                                Color("HomeBG").ignoresSafeArea()
                            )
                    }
                    
                    CustomNavigationLink(title: "Terms") {
                        //遷移先のViewを設定
                        Text("Hello!!")
                            .navigationTitle("Terms")
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background(
                                Color("HomeBG").ignoresSafeArea()
                            )
                    }

                }
                .padding([.horizontal, .vertical], 22)
            }
            .navigationBarHidden(true)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                Color("HomeBG").ignoresSafeArea()
            )
        }
    }
    
    // Reusable CellのようなView
    @ViewBuilder
    func CustomNavigationLink<T: View>(title: String,
                                       @ViewBuilder content: @escaping () -> T) -> some View {
        NavigationLink {
            // 遷移先のViewは 呼び出しもとのクロージャで受け取る
            content()
        } label: {
            // 表示するView
            HStack {
                Text(title)
                    .font(.custom(customFont, size: 17))
                    .fontWeight(.semibold)
                
                Spacer()
                
                Image(systemName: "chevron.right" )
            }
            .foregroundColor(.black)
            .padding()
            .background(
                Color.white
                    .cornerRadius(15)
            )
            .padding(.horizontal)
            .padding(.bottom, 14)
        }
    }
}

#Preview {
    ProfilePage()
}
