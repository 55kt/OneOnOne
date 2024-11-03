//
//  AuthScreenModel.swift
//  OneOnOne
//
//  Created by Vlad on 24/10/24.
//

import Foundation

@MainActor // Эта модель будет использоваться в главном потоке.
           // This model will be used in the main thread.
final class AuthScreenModel: ObservableObject {
    
    // MARK: - Properties
    @Published var isLoading: Bool = false
    @Published var phoneNumber: String = ""
    @Published var verificationCode: String = ""
    @Published var selectedCountry: Country = .defaultCountry
    @Published var errorState: (showError: Bool, errorMessage: String) = (false, "Error Message")
    @Published var isVerificationSent: Bool = false
    @Published var isAuthenticated: Bool = false
    
    private let authProvider: AuthProvider
    
    // MARK: - Initializer
    init(authProvider: AuthProvider = AuthManager.shared) {
        self.authProvider = authProvider
    }
    
    /*
     Проверяет, является ли номер телефона и код подтверждения пустыми.
     If the phone number or verification code is empty, returns true.
     */
    var disablePhoneNumberButton: Bool {
        return phoneNumber.isEmpty || isLoading
    }
    
    /*
     Проверяет, является ли код подтверждения пустым.
     If the verification code is empty, returns true.
     */
    var disableConfirmButton: Bool {
        return verificationCode.isEmpty || isLoading
    }
    
    /*
     Отправляет код подтверждения по SMS, предоставленный пользователем.
     Sends a verification code to the user's phone number using Firebase Phone Authentication.
     */
    func sendVerificationCode() async {
            isLoading = true
            do {
                let countryCode = selectedCountry.code
                let verificationID = try await AuthManager.shared.sendVerificationCode(to: phoneNumber, withCountryCode: countryCode)
                
                // Сохраняем verificationID и обновляем состояние
                UserDefaults.standard.set(verificationID, forKey: "authVerificationID")
                DispatchQueue.main.async {
                    self.isVerificationSent = true // Обновляем состояние
                    self.isLoading = false
                }
            } catch {
                DispatchQueue.main.async {
                    self.errorState.errorMessage = "Failed to send verification code: \(error.localizedDescription)"
                    self.errorState.showError = true
                    self.isLoading = false
                }
            }
        }
    
    /*
     Проверяет код подтверждения по SMS, предоставленный пользователем.
     Checks the verification code provided by the user.
     */
    func verifyCodeAndLogin() async {
        print("Starting handleLogin")
        guard let verificationID = UserDefaults.standard.string(forKey: "authVerificationID"), !verificationCode.isEmpty else {
            errorState = (true, "Verification ID or code is missing")
            print("Verification ID or code is missing")
            return
        }
        
        isLoading = true
        do {
            print("Calling verifyCode with ID: \(verificationID) and code: \(verificationCode)")
            try await authProvider.verifyCode(verificationCode, with: verificationID)
            isAuthenticated = true
            errorState = (false, "")
            print("Verification successful, user is authenticated")
        } catch {
            errorState = (true, "Failed to verify code: \(error.localizedDescription)")
            print("Failed to verify code: \(error.localizedDescription)")
        }
        isLoading = false
    }
    
    /*
     Выходит из аккаунта.
     Logs out of the account.
     */
    func handleLogout() async {
            isLoading = true
            do {
                try await AuthManager.shared.logout()
                DispatchQueue.main.async {
                    self.isAuthenticated = false
                    self.isVerificationSent = false
                    self.phoneNumber = ""
                    self.verificationCode = ""
                    self.isLoading = false
                }
            } catch {
                DispatchQueue.main.async {
                    self.errorState = (true, "Failed to log out: \(error.localizedDescription)")
                    self.isLoading = false
                }
            }
        }
    
    /*
     Автоматически входит в аккаунт.
     Auto logs in to the account.
     */
    func checkAutoLogin() async {
        await authProvider.autoLogin()
    }
}
