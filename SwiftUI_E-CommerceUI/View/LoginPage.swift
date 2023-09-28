//
//  LoginPage.swift
//  SwiftUI_E-CommerceUI
//
//  Created by パクギョンソク on 2023/09/26.
//

import SwiftUI

struct LoginPage: View {
    
    @Namespace var animation
    @StateObject var loginViewModel = LoginPageViewModel()
    var body: some View {
        
        VStack {
            Text("Welcome\nback")
                .font(.custom(customFont, size: 55).bold())
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity, alignment: .leading)
                .frame(height: getRect().height / 3.5)
                .padding()
                .background(
                    // Bubblesを描画....
                    
                    ZStack {
                        // CircleCradient
                        LinearGradient(colors: [Color("LoginCircle"), Color("LoginCircle").opacity(0.5), Color("Purple")],  startPoint: .top, endPoint: .bottom)
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                            .padding(.trailing)
                            .padding(.top)
                        
                        Circle()
                            .strokeBorder(Color.white.opacity(0.3), lineWidth: 2)
                            .frame(width: 30, height: 30)
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomLeading)
                            .padding(.leading)
                            .padding(.bottom)
                        
                        Circle()
                            .strokeBorder(Color.white.opacity(0.1), lineWidth: 2)
                            .blur(radius: 1)
                            .frame(width: 120, height: 120)
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                            .offset(x: 50, y: 50)
                            .padding(.bottom)
                    }
                )
            
            
            ScrollView(.vertical, showsIndicators: false) {
                
                VStack(spacing: 15) {
                    Text("Login")
                        .font(.custom(customFont, size: 22).bold())
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    // Custom TextField
                    CustomTextField(icon: "envelope", 
                                    title: "Email",
                                    placeholder: "email",
                                    showPassword: .constant(false),
                                    value: $loginViewModel.email)
                    .padding(.top, 30)
                    
                    CustomTextField(icon: "lock",
                                    title: "Password",
                                    placeholder: "password",
                                    showPassword: $loginViewModel.showPassword,
                                    value: $loginViewModel.password
                                    )
                    .padding(.top, 30)
                    
                    if loginViewModel.isRegisterUserMode {
                        //Register Re-enter password
                        CustomTextField(icon: "lock",
                                        title: "Re-Enter Password",
                                        placeholder: "password",
                                        showPassword: $loginViewModel.showReEnterPassword,
                                        value: $loginViewModel.reEnterPassword)
                        .padding(.top, 30)
                    }
                    
                    if !loginViewModel.isRegisterUserMode {
                        Button {
                            loginViewModel.forgotPassword()
                        } label: {
                            Text("Forgot password?")
                                .font(.custom(customFont, size: 13))
                                .fontWeight(.semibold)
                                .foregroundStyle(Color("Purple"))
                                .padding(.top, 8)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                   
                    // Register / LogIn Button
                    if loginViewModel.isRegisterUserMode {
                        SubmitButton(with: "Register")
                    } else {
                        SubmitButton(with: "Login")
                    }
                    
                    // Register User Button
                    Button {
                        withAnimation {
                            loginViewModel.isRegisterUserMode.toggle()

                        }
                    } label: {
                        Text(loginViewModel.isRegisterUserMode ? "Back to Log In" : "Create account")
                            .font(.custom(customFont, size: 14))
                            .fontWeight(.semibold)
                            .foregroundStyle(Color("Purple"))
                    }
                    .padding(.top, 8)
                   
                }
                .padding(30)

            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                Color.white
                    .clipShape(CustomCorner(corner: [.topLeft, .topRight], cornerRadius: 25))
            )
        }
        .background(
            Color("Purple")
        )
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onChange(of: loginViewModel.isRegisterUserMode) { _, _ in
            loginViewModel.email = ""
            loginViewModel.password = ""
            loginViewModel.reEnterPassword = ""
            loginViewModel.showPassword = false
            loginViewModel.showReEnterPassword = false
            
        }
        .ignoresSafeArea()
    }
    
    @ViewBuilder
    func CustomTextField(icon: String, 
                         title: String,
                         placeholder: String,
                         showPassword: Binding<Bool>,
                         value: Binding<String>) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Label {
                Text(title)
                    .font(.custom(customFont, size: 14))
            } icon: {
                Image(systemName: icon)
            }
            .foregroundColor(Color.black.opacity(0.7))
            
            HStack {
                if title.contains("Password") && !showPassword.wrappedValue{
                    SecureField(placeholder, text: value)
                } else {
                    TextField(placeholder, text: value) {
                        
                    }
                }
                
                if title.contains("Password") {
                    Button {
                        loginViewModel.showPassword.toggle()
                    } label: {
                        Text(loginViewModel.showPassword ? "Hide" : "Show")
                            .font(.custom(customFont, size: 13).bold())
                            .foregroundColor(Color("Purple"))
                    }
                    .offset(y: 10)
                }
            }
           
            Divider()
        }
    }
    
    @ViewBuilder
    func SubmitButton(with title: String) -> some View {
        Button {
            loginViewModel.forgotPassword()

        } label: {
            Text(title)
                .font(.custom(customFont, size: 17).bold())

                .padding(.vertical, 20)
                .frame(maxWidth: .infinity)
                .background(Color("Purple"))
                .foregroundColor(.white)
                .cornerRadius(15)
                .shadow(color: .black.opacity(0.1), radius: 5, x: 5, y: 5)
                .matchedGeometryEffect(id: "LOGIN_BUTTON", in: animation)
        }
        .padding(.top, 25)
        .padding(.horizontal)
    }
}


#Preview {
    LoginPage()
}
