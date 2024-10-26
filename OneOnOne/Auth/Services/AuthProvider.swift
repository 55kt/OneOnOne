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

enum AuthState {
    case pending, loggedIn, loggedOut
}

protocol AuthProvider {
    static var shared: AuthProvider { get }
    var authState: CurrentValueSubject<AuthState, Never> { get }
    func autoLogin() async
    func login(with phoneNumber: String) async throws
    func createAccount(with phoneNumber: String) async throws
    func logout() async throws
}

final class AuthManager: AuthProvider {
    
    private init() {
        
    }
    
    static let shared: AuthProvider = AuthManager()
    
    var authState = CurrentValueSubject<AuthState, Never>(.pending)
    
    func autoLogin() async {
        <#code#>
    }
    
    func login(with phoneNumber: String) async throws {
        <#code#>
    }
    
    func createAccount(with phoneNumber: String) async throws {
        /*
         Store the new user info in database
         Сохраняет информацию о новом пользователе в базе данных
         */
        let authResult = try await PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber)
        let uid = authResult.user.uid 
        let newUser = UserItem(uid: uid, phoneNumber: phoneNumber, profileImageUrl: nil)
        try await saveUserInfoDatabase(user: newUser)
    }
    
    func logout() async throws {
        <#code#>
    }
}

extension AuthManager {
    private func saveUserInfoDatabase(user: UserItem) async throws {
        let userDictionary = ["uid": user.uid, "phoneNumber": user.phoneNumber]
        
        try await Database.database().reference().child("users").child(user.uid).setValue(userDictionary)
    }
}

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
