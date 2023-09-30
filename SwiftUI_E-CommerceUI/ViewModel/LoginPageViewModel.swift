//
//  LoginPageViewModel.swift
//  SwiftUI_E-CommerceUI
//
//  Created by パクギョンソク on 2023/09/26.
//

import SwiftUI

class LoginPageViewModel: ObservableObject {
    
    // For Login
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var showPassword: Bool = false
    
    // For Register
    @Published var reEnterPassword: String = ""
    @Published var showReEnterPassword: Bool = false
    
    @Published var isRegisterUserMode: Bool = false

    @AppStorage("log_status") var log_status = false

    func login() {
        log_status = true
    }
    
    func register() {
        log_status = true
    }
    
    func forgotPassword() {
        
    }
}
