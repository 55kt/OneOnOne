//
//  InitialView.swift
//  OneOnOne
//
//  Created by Vlad on 20/10/24.
//

import SwiftUI
import FirebaseAuth

struct InitialView: View {
    // MARK: - Properties
    @State private var userLoggedIn = (Auth.auth().currentUser != nil)
    @State private var authStateListenerHandle: AuthStateDidChangeListenerHandle?
    
    // MARK: - Body
    var body: some View {
        NavigationStack {
            
            if userLoggedIn{
                MainTabView()
            } else {
                SendVerificationCodeView(phoneNumberInput: .constant("")) {}
            }
            
        }.onAppear {
            // Сохраняем хэндлер
            authStateListenerHandle = Auth.auth().addStateDidChangeListener { auth, user in
                if let _ = user {
                    userLoggedIn = true
                } else {
                    userLoggedIn = false
                }
            }
        }.onDisappear {
            // Удаляем хэндлер, когда View исчезает
            if let handle = authStateListenerHandle {
                Auth.auth().removeStateDidChangeListener(handle)
            }
        }
    }
}

// MARK: - Preview
#Preview {
    InitialView()
}
