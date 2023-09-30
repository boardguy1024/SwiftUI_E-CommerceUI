//
//  ContentView.swift
//  SwiftUI_E-CommerceUI
//
//  Created by パクギョンソク on 2023/09/26.
//

import SwiftUI

struct ContentView: View {
    
    // login-out status
    @AppStorage("log_status") var log_status = false
    
    var body: some View {
        Group {
            if log_status {
                MainPage()
            } else {
                OnboardingPage()
            }
        }
    }
}

#Preview {
    ContentView()
}
