//
//  LoginView.swift
//  AuthenticationApp
//
//  Created by Abiodun Osagie on 09/05/2025.
//

import SwiftUI

struct LoginView: View {
    // MARK: - PROPERRTIES
    @Environment(AuthManager.self) private var authManager
    
    @State private var email = ""
    @State private var password = ""
    

    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                Image(.applogo)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                    .padding()
                
                VStack(spacing: 8) {
                    TextField("Enter your email", text: $email)
                        .autocapitalization(.none)
                        .font(.subheadline)
                        .padding(12)
                        .background(Color(.systemGray6))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .padding(.horizontal, 24)
                    
                    SecureField("Enter your password", text: $password)
                        .font(.subheadline)
                        .padding(12)
                        .background(Color(.systemGray6))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .padding(.horizontal, 24)
                }//: VSTACK
                Button {
                   signIn()
                } label: {
                    Text("Login")
                        .font(.headline)
                        .foregroundStyle(.white)
                        .frame(width: 352, height: 50)
                        .background(Color(.systemBlue))
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                }
                .disabled(!formIsValid)
                .opacity(formIsValid ? 1.0 : 0.5)
                .padding(.vertical)

                Spacer()
                Divider()
                NavigationLink {
                    SignupView()
                        .navigationBarBackButtonHidden()
                } label:  {
                    HStack(spacing: 3){
                        Text("Don't have an account? ")
                        Text("Sign Up")
                            .fontWeight(.semibold)
                    }
                    .font(.subheadline)
                }
                .padding(.vertical, 16)
            }//: VSTACK
        }//: NAVIGATION STACK
    }
}

// MARK: - PRIVATE EXTENSIONS
extension String {
    func isValidEmail() -> Bool {
        let regex = #"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"#
        return NSPredicate(format: "SELF MATCHES %@", regex)
            .evaluate(with: self)
    }
}

private extension LoginView {
    func signIn() {
        Task { await authManager.signIn(email: email, password: password)}
    }
    
    var formIsValid: Bool {
        return email.isValidEmail() && !password.isEmpty
    }
}



// MARK: - PREVIEW
#Preview {
    LoginView()
        .environment(AuthManager())
}
