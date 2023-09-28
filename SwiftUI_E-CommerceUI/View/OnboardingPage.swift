//
//  OnboardingPage.swift
//  SwiftUI_E-CommerceUI
//
//  Created by パクギョンソク on 2023/09/26.
//

import SwiftUI

let customFont = "Raleway-Regular"

struct OnboardingPage: View {
    
    @State private var showLoginView = false
    
    var body: some View {
        
        VStack {
            Text("Find your\nGadget")
                .font(.custom(customFont, size: 55))
                .fontWeight(.semibold)
                .foregroundStyle(.white)
            
            Image("OnBoard")
                .resizable()
                .scaledToFit()
            
            Button {
                showLoginView = true
            } label: {
                Text("Get started")
                    .font(.custom(customFont, size: 18))
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 18)
                    .background(.white)
                    .foregroundColor(Color("Purple"))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            }
            .padding(.horizontal, 30)
            .padding(.top, 20)
            .shadow(color: Color.black.opacity(0.2), radius: 20)
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            Color("Purple")
        )
        .fullScreenCover(isPresented: $showLoginView, content: {
            LoginPage()
        })
    }
}

#Preview {
    OnboardingPage()
}

extension View {
    func getRect() -> CGRect {
        UIScreen.main.bounds
    }
}
