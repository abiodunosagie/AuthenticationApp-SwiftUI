//
//  SupabaseAuthService.swift
//  AuthenticationApp
//
//  Created by Abiodun Osagie on 09/05/2025.
//

import Foundation
import Supabase

struct SupabaseAuthService {
    private let client: SupabaseClient
    
    init() {
        self.client = SupabaseClient.init(
            supabaseURL: URL(string: Constants.projectURLString)!,
            supabaseKey: Constants.projectAPIKey
        )
    }
    
    func signUp(email: String, password: String) async throws  -> User {
        let response = try await client.auth.signUp(
            email: email,
            password: password
        )
        print(response.user)
        guard let email = response.user.email else {
            print("DEBUG: No email!")
            throw NSError()
        }
        return User(id: response.user.aud, email: email)
    }
    func signIn(email: String, password: String) async throws -> User{
        let response = try await client.auth.signIn(
            email: email,
            password: password
        )
        print(response.user)
        guard let email = response.user.email else {
            print("DEBUG: No email!")
            throw NSError()
        }
        return User(id: response.user.aud, email: email)
    }
    func signOut() async throws {
        try await client.auth.signOut()
    }
}

