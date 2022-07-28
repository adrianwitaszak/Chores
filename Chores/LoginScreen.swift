//
//  LoginScreen.swift
//  Chores
//
//  Created by Adrian Witaszak on 28/07/2022.
//

import SwiftUI

enum LoginScreenState {
    case login, register, forgotPassword
}

struct LoginScreen: View {
    @EnvironmentObject var viewModel: AuthViewModel
    
    @State var state: LoginScreenState = .login
    @State var isShowingRegistration: Bool = false
    @State var email: String = ""
    @State var password: String = ""
    @State var repeatPassword: String = ""
    
    var buttonLabel: String {
        switch state {
        case .login:
            return "Login"
        case .register:
            return "Register"
        case .forgotPassword:
            return "Remind Password"
        }
    }
    
    var bottomLinkLabel: String {
        switch state {
        case .login:
            return "Don't have an account? Register"
        case .register:
            return "Have an account already? Login"
        case .forgotPassword:
            return ""
        }
    }
    
    var buttonAction: () -> Void {
        switch state {
        case .login:
            return { viewModel.login(with: email, and: password) }
        case .register:
            return { viewModel.register(with: email, and: password) }
        case .forgotPassword:
            return { viewModel.resetPassword() }
        }
    }
    
    func login() {
        viewModel.login(with: email, and: password)
    }
    
    func register() {
        viewModel.register(with: email, and: password)
    }
    
    func forgotPassword() {
        viewModel.resetPassword()
        state = .login
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                BackgroundGradientView()
                
                VStack {
                    LogoView()
                        .padding(.top, 48)
                    Spacer()
                    
                    VStack(spacing: 20) {
                        CustomTextField(
                            value: $email,
                            imageName: "envelope",
                            placeholder: "Email"
                        )
                        CustomTextField(
                            value: $password,
                            imageName: "lock",
                            placeholder: "Password",
                            isSecure: true
                        )
                        if state == .register {
                            CustomTextField(
                                value: $repeatPassword,
                                imageName: "lock",
                                placeholder: "Repeat Password",
                                isSecure: true
                            )

                            .transition(.moveAndFade)
                        }
                        if state == .login {
                            HStack {
                                Spacer()
                                CustomPlainButton(
                                    text: "Forgot Password",
                                    action: {
                                        withAnimation {
                                            state = .forgotPassword
                                        }
                                    }
                                )
                            }
                            .transition(.moveInAndFade)
                        }
                    }
                    Spacer()
                    
                    VStack {
                        Button(action: {
                            withAnimation {
                                buttonAction()
                            }
                        }) {
                            Text(buttonLabel)
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(width: 360, height: 50)
                                .background(.blue.opacity(0.8))
                                .cornerRadius(10)
                        }
                        .padding(.bottom, 30)
                        .disabled(email.isEmpty || password.isEmpty)
                        
                        Button(
                            action: {
                                withAnimation {
                                    state = state == .login ? .register : .login
                                }
                            }
                        ) {
                            Text(bottomLinkLabel)
                        }
                        .foregroundColor(.white)
                    }
                }
                .padding()
            }
        }
        .eraseToAnyView()
    }

    #if DEBUG
    @ObservedObject var iO = injectionObserver
    #endif
}

struct LoginScreen_Previews: PreviewProvider {
    static var previews: some View {
        LoginScreen()
    }
}

extension AnyTransition {
    static var moveAndFade: AnyTransition {
        .asymmetric(
            insertion: .move(edge: .bottom).combined(with: .opacity),
            removal: .scale.combined(with: .opacity)
        )
    }
    
    static var moveInAndFade: AnyTransition {
        .asymmetric(
            insertion: .move(edge: .top).combined(with: .opacity),
            removal: .move(edge: .bottom).combined(with: .opacity)
        )
    }
}
