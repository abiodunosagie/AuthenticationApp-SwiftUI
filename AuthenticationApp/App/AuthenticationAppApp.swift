//
//  AuthenticationAppApp.swift
//  AuthenticationApp
//
//  Created by Abiodun Osagie on 09/05/2025.
//

import SwiftUI

@main
struct AuthenticationAppApp: App {
    @State private var authManager = AuthManager()
    
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .environment(authManager)
        }
    }
}
