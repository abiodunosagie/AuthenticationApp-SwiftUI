//
//  AuthManager.swift
//  AuthenticationApp
//
//  Created by Abiodun Osagie on 09/05/2025.
//

import Foundation
import Observation

@Observable
@MainActor

class AuthManager {
    private let authService: SupabaseAuthService
    var currentUser: User?
    
    init(authService: SupabaseAuthService = SupabaseAuthService()) {
        self.authService = authService
    }
    
    func signUp(email: String, password: String) async {
        do {
            self.currentUser =  try await authService
                .signUp(email: email, password: password)
        } catch {
            print("DEBUG: SignUp error: \(error.localizedDescription)")
            
        }
    }
    
    func signIn(email: String, password: String) async {
        do {
            self.currentUser =   try await authService
                .signIn(email: email, password: password)
        } catch {
            print("DEBUG: SignIn error: \(error.localizedDescription)")
            
        }
    }
    
    func signOut() async  {
        do {
            try await authService.signOut()
            currentUser = nil
        } catch {
            print("DEBUG: SignOut error: \(error.localizedDescription)")
        }
    }
}
