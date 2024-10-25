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
    @ObservedObject private var authModel = AuthScreenModel()
    
    @State private var userLoggedIn = (Auth.auth().currentUser != nil)
    @State private var authStateListenerHandle: AuthStateDidChangeListenerHandle?
    
    @State var selectedCountry: Country
    
    // MARK: - Body
    var body: some View {
        NavigationStack {
            
            if userLoggedIn{
                MainTabView()
            } else {
                SendVerificationCodeView(phoneNumberInput: $authModel.phoneNumber, selectedCountry: $selectedCountry) {}
                    .environmentObject(authModel)
            }
            
        }.onAppear {
            /*
             Сохраняем хэндлер
             Saves the handler
             */
            authStateListenerHandle = Auth.auth().addStateDidChangeListener { auth, user in
                if let _ = user {
                    userLoggedIn = true
                } else {
                    userLoggedIn = false
                }
            }
        }.onDisappear {
            /*
             Удаляем хэндлер, когда View исчезает
             Removes the handler when the view disappears
             */
            if let handle = authStateListenerHandle {
                Auth.auth().removeStateDidChangeListener(handle)
            }
        }
    }
}

// MARK: - Preview
#Preview {
    InitialView(selectedCountry: Country.defaultCountry)
}
