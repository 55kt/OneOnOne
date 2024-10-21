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
    @State private var phoneNumber: String = ""
    @State private var verificationID: String?
    @State private var verificationCode: String = ""
    @State private var isVerificationSent: Bool = false
    @State private var isAuthenticated: Bool = false
    @State private var errorMessage: String?
    
    // MARK: - Body
    var body: some View {
        NavigationStack {
            
            if isAuthenticated {
                MainTabView()
            } else {
                if !isVerificationSent {
                    
                    SendVerificationCodeView(phoneNumberInput: $phoneNumber) { sendVerificationCode() }
                    
                    if let errorMessage = errorMessage {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .padding()
                    }
                } else {
                    
                    ConfirmVerifyCodeView(verificationCode: $verificationCode) {
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
    }
    
    // MARK: - Methods
    
    private func sendVerificationCode() {
        let phoneNumber = self.phoneNumber
        let phoneNumberWithCountryCode = "+30\(phoneNumber)" // Replace "+1" with the country code if needed
        
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
        
        let credential = PhoneAuthProvider.provider().credential(withVerificationID: verificationID, verificationCode: verificationCode)
        
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
    ContentView()
}
