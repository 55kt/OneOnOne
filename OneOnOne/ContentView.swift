//
//  ContentView.swift
//  OneOnOne
//
//  Created by Vlad on 20/10/24.
//

import SwiftUI
import Firebase
import FirebaseAuth

struct ContentView: View {

    // MARK: - Properties
    @EnvironmentObject var authModel: AuthScreenModel

    @State private var verificationID: String?
    @State private var isVerificationSent: Bool = false
    @State private var isAuthenticated: Bool = (Auth.auth().currentUser != nil)
    @State private var errorMessage: String?
    
    @State private var authStateListenerHandle: AuthStateDidChangeListenerHandle?
    
    @State var selectedCountry: Country

    // MARK: - Body
    var body: some View {
        Section {
            if isAuthenticated {
                MainTabView()
            } else {
                if !isVerificationSent {
                    SendVerificationCodeView(phoneNumberInput: $authModel.phoneNumber, selectedCountry: $selectedCountry) { sendVerificationCode() }
                    
                    if let errorMessage = errorMessage {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .padding()
                    }
                } else {
                    ConfirmVerifyCodeView(verificationCode: $authModel.verificationCode) {
                        verifyCode()
                    }
                    
                    if let errorMessage = errorMessage {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .padding()
                    }
                }
            }
        }
        .onAppear {
            // Добавляем наблюдателя за состоянием аутентификации
            authStateListenerHandle = Auth.auth().addStateDidChangeListener { auth, user in
                if let _ = user {
                    isAuthenticated = true
                } else {
                    isAuthenticated = false
                }
            }
        }
        .onDisappear {
            // Удаляем наблюдателя
            if let handle = authStateListenerHandle {
                Auth.auth().removeStateDidChangeListener(handle)
            }
        }
    }

    // MARK: - Methods

    private func sendVerificationCode() {
        let phoneNumber = authModel.phoneNumber
        let countryCode = selectedCountry.code.trimmingCharacters(in: .whitespacesAndNewlines)
        let phoneNumberWithCountryCode = "\(countryCode)\(phoneNumber)"
        
        print("Sending phone number: \(phoneNumberWithCountryCode)")
        
        guard phoneNumber.count > 6 && phoneNumber.count < 15 else {
            self.errorMessage = "Error: Phone number is too long or too short"
            return
        }
        
        PhoneAuthProvider.provider()
            .verifyPhoneNumber(phoneNumberWithCountryCode, uiDelegate: nil) { (verificationID, error) in
                if let error = error {
                    self.errorMessage = "Error: \(error.localizedDescription)"
                    return
                }
                self.verificationID = verificationID
                self.isVerificationSent = true
                self.errorMessage = nil
            }
    }

    private func verifyCode() {
        guard let verificationID = self.verificationID else {
            self.errorMessage = "Verification ID is missing."
            return
        }
        
        print("Verification code entered: \(authModel.verificationCode)")
        
        let credential = PhoneAuthProvider.provider().credential(withVerificationID: verificationID, verificationCode: authModel.verificationCode)
        
        Auth.auth().signIn(with: credential) { (authResult, error) in
            if let error = error {
                self.errorMessage = "Error: \(error.localizedDescription)"
                return
            }
            self.isAuthenticated = true
            self.errorMessage = nil
        }
    }
}

// MARK: - Preview
#Preview {
    NavigationStack {
        ContentView(selectedCountry: Country.defaultCountry)
            .environmentObject(ThemeManager())
            .environmentObject(AuthScreenModel())
    }
}
