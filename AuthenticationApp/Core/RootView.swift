//
//  ContentView.swift
//  AuthenticationApp
//
//  Created by Abiodun Osagie on 09/05/2025.
//

import SwiftUI

struct RootView: View {
    // MARK: - PROPERTIES
    @Environment(AuthManager.self) private var authManager
    
    
    // MARK: - BODY
    var body: some View {
        Group {
            if let currentUser = authManager.currentUser {
                Text("Main View")
            } else {
                LoginView()
            }
        }
        .task {
            await authManager.refreshUser()
        }
    }
}

#Preview {
    RootView()
        .environment(AuthManager())
}
