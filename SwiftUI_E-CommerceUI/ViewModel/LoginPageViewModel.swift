//
//  LoginPageViewModel.swift
//  SwiftUI_E-CommerceUI
//
//  Created by パクギョンソク on 2023/09/26.
//

import Foundation

class LoginPageViewModel: ObservableObject {
    
    // For Login
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var showPassword: Bool = false
    
    // For Register
    @Published var reEnterPassword: String = ""
    @Published var showReEnterPassword: Bool = false
    
    @Published var isRegisterUserMode: Bool = false

    func login() {
        
    }
    
    func register() {
        
    }
    
    func forgotPassword() {
        
    }
}
