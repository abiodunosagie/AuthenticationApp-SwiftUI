//
//  SignupView.swift
//  AuthenticationApp
//
//  Created by Abiodun Osagie on 09/05/2025.
//

import SwiftUI

struct SignupView: View {
    // MARK: - PROPERTIES
    @Environment(\.dismiss) private var dismiss
    @Environment(AuthManager.self) private var authManager
    
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var passwordMatch = false
    
    
    
    // MARK: - BODY
    var body: some View {
        VStack {
            Spacer()
            
            Image(.applogo)
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
                .padding()
            
            VStack(spacing: 8){
                TextField("Enter your email", text: $email)
                    .autocapitalization(.none)
                    .font(.subheadline)
                    .padding(12)
                    .background(Color(.systemGray6))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding(.horizontal, 24)
                ZStack(alignment: .trailing) {
                    SecureField("Enter your password", text: $password)
                        .font(.subheadline)
                        .padding(12)
                        .background(Color(.systemGray6))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    if !password.isEmpty && !confirmPassword.isEmpty {
                        Image(systemName: passwordMatch ? "checkmark.circle.fill" : "xmark.circle.fill")
                            .foregroundStyle(passwordMatch ? .green : .red)
                            .padding(.horizontal)
                    }
                }//: ZSTACK
                .padding(.horizontal, 24)
                
                ZStack(alignment: .trailing) {
                    SecureField("Confirm your password", text: $confirmPassword)
                        .font(.subheadline)
                        .padding(12)
                        .background(Color(.systemGray6))
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                    
                    if !password.isEmpty && !confirmPassword.isEmpty {
                        Image(systemName: passwordMatch ? "checkmark.circle.fill" : "xmark.circle.fil")
                            .foregroundStyle(passwordMatch ? .green : .red)
                            .padding(.horizontal)
                    }
                }
                .padding(.horizontal, 24)
                .onChange(of: confirmPassword) { oldValue, newValue in
                    passwordMatch = newValue == password
                }
            }//: VSTACK
            
            Button {
                signUp()
            } label: {
                Text("Sign Up")
                    .font(.headline)
                    .fontWeight(.semibold)
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
            
            Button {
                dismiss()
            } label: {
                HStack(spacing: 3) {
                    Text("Already have an account? ")
                    
                    Text("Sign In")
                        .fontWeight(.semibold)
                }
                .font(.subheadline)
            }
            .padding(.vertical, 16)

        }//: VSTACK
    }
}


// MARK: - PRIVATE EXTENSION for spice.
private extension SignupView {
    func signUp() {
        Task { await authManager.signUp(email: email, password: password)}
    }
    var formIsValid: Bool {
        return email.isValidEmail() && passwordMatch
    }
}

// MARK: - PREVIEW
#Preview {
    SignupView()
        .environment(AuthManager())
}
