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
    private init() {
            Task { await autoLogin() }
        }
    
    /*
     Авто авторизация
     Auto login
     */
    func autoLogin() async {
            if Auth.auth().currentUser == nil {
                authState.send(.loggedOut)
            } else {
                fetcCurrentUserInfo()
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
        let authResult = try await Auth.auth().signIn(with: credential)
        
        // Создаем объект UserItem после успешной аутентификации
        let user = UserItem(uid: authResult.user.uid, phoneNumber: authResult.user.phoneNumber ?? "")
        try await saveUserInfoDatabase(user: user)
        
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
                do {
                    // Составляем словарь пользователя с проверкой на nil
                    var userDictionary: [String: Any] = [
                        "uid": user.uid,
                        "phoneNumber": user.phoneNumber
                    ]
                    
                    if let username = user.username {
                        userDictionary["username"] = username
                    }
                    if let dateOfBirth = user.dateOfBirth {
                        userDictionary["dateOfBirth"] = dateOfBirth.timeIntervalSince1970
                    }
                    if let profileImageUrl = user.profileImageUrl {
                        userDictionary["profileImageUrl"] = profileImageUrl
                    }
                    
                    // Сохранение информации пользователя в Firebase
                    try await Database.database().reference().child("users").child(user.id).setValue(userDictionary)
                } catch {
                    print("🔐 Failed to Save Created user info to Database: \(error.localizedDescription)")
                }
            }
        
        private func fetcCurrentUserInfo() {
                guard let currentUid = Auth.auth().currentUser?.uid else { return }
                
                Database.database().reference().child("users").child(currentUid).observeSingleEvent(of: .value) { [weak self] snapshot in
                    guard let userDict = snapshot.value as? [String: Any],
                          let loggedInUser = UserItem(dictionary: userDict) else {
                        print("Failed to parse user data")
                        return
                    }
                    
                    DispatchQueue.main.async {
                        self?.authState.send(.loggedIn) // Обновляем состояние аутентификации
                    }
                    print("🔐 User: \(loggedInUser.username ?? "Unknown") is logged in")
                } withCancel: { error in
                    print("Failed to get current user info with error: \(error.localizedDescription)")
                }
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

extension UserItem {
    init?(dictionary: [String: Any]) {
        guard let uid = dictionary["uid"] as? String,
              let phoneNumber = dictionary["phoneNumber"] as? String else { return nil }
        
        self.uid = uid
        self.phoneNumber = phoneNumber
        self.username = dictionary["username"] as? String
        if let dateOfBirthTimestamp = dictionary["dateOfBirth"] as? TimeInterval {
            self.dateOfBirth = Date(timeIntervalSince1970: dateOfBirthTimestamp)
        }
        self.profileImageUrl = dictionary["profileImageUrl"] as? String
    }
}
