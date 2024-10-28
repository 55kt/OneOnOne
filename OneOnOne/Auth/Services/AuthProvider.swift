//
//  AuthProvider.swift
//  OneOnOne
//
//  Created by Vlad on 26/10/24.
//

import Foundation
import Combine
import FirebaseAuth
import FirebaseDatabase

/*
 Enum который содержит состояния авто авторизации
 Enum which contains the states of the auto login
 */
enum AuthState {
    case pending, loggedIn, loggedOut
}

/*
 Protocol для работы с авторизацией
 Protocol for working with authorization
 */
protocol AuthProvider {
    // MARK: - Properties
    static var shared: AuthProvider { get }
    var authState: CurrentValueSubject<AuthState, Never> { get }
    func autoLogin() async
    func sendVerificationCode(to phoneNumber: String, withCountryCode countryCode: String) async throws -> String
    func verifyCode(_ verificationCode: String, with verificationID: String) async throws
    func logout() async throws
}

/*
 Класс для работы с авторизацией
 Class for working with authorization
 */
final class AuthManager: AuthProvider {
    
    // MARK: - Properties
    static let shared: AuthProvider = AuthManager()
    @Published var authState = CurrentValueSubject<AuthState, Never>(.pending)
    
    // MARK: - Initializer
    private init() {}
    
    /*
     Авто авторизация
     Auto login
     */
    func autoLogin() async {
        if let user = Auth.auth().currentUser {
            print("User \(user.uid) is already logged in.")
            self.authState.send(.loggedIn)
        } else {
            self.authState.send(.loggedOut)
        }
    }
    
    /*
     Отправка кода верификации
     Sending verification code
     */
    func sendVerificationCode(to phoneNumber: String, withCountryCode countryCode: String) async throws -> String {
        let fullPhoneNumber = "\(countryCode)\(phoneNumber)"
        let verificationID = try await PhoneAuthProvider.provider().verifyPhoneNumber(fullPhoneNumber)
        UserDefaults.standard.set(verificationID, forKey: "authVerificationID")
        return verificationID
    }
    
    /*
     Подтверждение кода верификации
     Confirmation code verification
     */
    func verifyCode(_ verificationCode: String, with verificationID: String) async throws {
        let credential = PhoneAuthProvider.provider().credential(withVerificationID: verificationID, verificationCode: verificationCode)
        _ = try await Auth.auth().signIn(with: credential)
        self.authState.send(.loggedIn)
    }
    
    /*
     Выход
     Logout
     */
    func logout() async throws {
        do {
            try Auth.auth().signOut()
            DispatchQueue.main.async {
                self.authState.send(.loggedOut) // Обновляем состояние аутентификации
            }
        } catch {
            throw error
        }
    }
}
    
/*
 Создает нового юзера в БД
 Creates a new user in the DB
 */
    extension AuthManager {
        private func saveUserInfoDatabase(user: UserItem) async throws {
            let userDictionary = ["uid": user.uid, "phoneNumber": user.phoneNumber]
            
            try await Database.database().reference().child("users").child(user.uid).setValue(userDictionary)
        }
    }
    
/*
 Этот struct делает
 
 */
    struct UserItem: Identifiable, Hashable, Decodable {
        let uid: String
        let phoneNumber: String
        var username: String? = nil
        var dateOfBirth: Date? = nil
        var profileImageUrl: String? = nil
        
        var id: String {
            return uid
        }
    }
