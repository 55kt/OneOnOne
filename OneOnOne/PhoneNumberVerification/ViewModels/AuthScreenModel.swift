//
//  AuthScreenModel.swift
//  OneOnOne
//
//  Created by Vlad on 24/10/24.
//

import Foundation

final class AuthScreenModel: ObservableObject {
    
    @Published var isLoading: Bool = false
    @Published var phoneNumber: String = ""
    @Published var verificationCode: String = ""
    @Published var selectedCountry: Country = .defaultCountry
    @Published var isPhoneNumberCorrect: Bool = false
    @Published var errorState: (showError: Bool, errorMessage: String) = (false, "errorMassage")
    
    var disablePhoneNumberButton: Bool {
        return phoneNumber.isEmpty || isLoading
    }
    
    var disableConfirmButton: Bool {
        return verificationCode.isEmpty || isLoading
    }
    
    func handleSignUp() async {
        isLoading = true
        do {
            try await AuthManager.shared.createAccount(with: phoneNumber)
        } catch {
            errorState.errorMessage = "Failed to create an account \(error.localizedDescription)"
            errorState.showError = true
            isLoading = false
        }
    }
}
