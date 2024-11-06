//
//  AuthErrors.swift
//  OneOnOne
//
//  Created by Vlad on 6/11/24.
//

import Foundation

// Перечисление ошибок для авторизации и создания пользователя
// Enumeration for authorization and creating a user
enum AuthError: Error {
    case accountCreationFailed(_ description: String)
    case failedToSaveUserInfo(_ description: String)
    case phoneNumberLoginFailed(_ description: String)
    case verificationCodeFailed(_ description: String)
    case logoutFailed(_ description: String)
    case userFetchFailed(_ description: String)
}

// Расширение для предоставления описания ошибок AuthError
// Extension to provide error descriptions for AuthError
extension AuthError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .accountCreationFailed(let description):
            return "Account creation failed: \(description)"
        case .failedToSaveUserInfo(let description):
            return "Failed to save user info: \(description)"
        case .phoneNumberLoginFailed(let description):
            return "Phone number login failed: \(description)"
        case .verificationCodeFailed(let description):
            return "Verification code error: \(description)"
        case .logoutFailed(let description):
            return "Logout failed: \(description)"
        case .userFetchFailed(let description):
            return "User fetch failed: \(description)"
        }
    }
}
