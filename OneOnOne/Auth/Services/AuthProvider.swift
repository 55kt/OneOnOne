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
    case pending, loggedIn(UserItem), loggedOut
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

// Класс для работы с авторизацией
// Class for working with authorization
final class AuthManager: AuthProvider {
    
    // MARK: - Properties
    static let shared: AuthProvider = AuthManager()
    @Published var authState = CurrentValueSubject<AuthState, Never>(.pending)
    
    // MARK: - Initializer
    private init() {
        Task { await autoLogin() }
    }
    
    // Автоматически входит в аккаунт
    // Auto logs in to the account
    func autoLogin() async {
        if Auth.auth().currentUser == nil {
            authState.send(.loggedOut)
        } else {
            fetcCurrentUserInfo()
        }
    }
    
    // Отправляем код верификации
    // Send verification code
    func sendVerificationCode(to phoneNumber: String, withCountryCode countryCode: String) async throws -> String {
        let fullPhoneNumber = "\(countryCode)\(phoneNumber)"
        let verificationID = try await PhoneAuthProvider.provider().verifyPhoneNumber(fullPhoneNumber)
        UserDefaults.standard.set(verificationID, forKey: "authVerificationID")
        return verificationID
    }
    
    // Подтверждаем код верификации
    // Confirm the verification code
    func verifyCode(_ verificationCode: String, with verificationID: String) async throws {
        print("🔐 Starting verification with ID: \(verificationID) and code: \(verificationCode)")
        
        do {
            let credential = PhoneAuthProvider.provider().credential(withVerificationID: verificationID, verificationCode: verificationCode)
            let authResult = try await Auth.auth().signIn(with: credential)
            
            let userID = authResult.user.uid
            let userPhoneNumber = authResult.user.phoneNumber ?? ""
            
            // Проверка, существует ли пользователь в базе данных
            // Check if the user exists in the database
            let userRef = Database.database().reference().child("users").child(userID)
            let snapshot = try await userRef.getData()
            
            if snapshot.exists() {
                // Пользователь уже существует, просто обновляем состояние
                // User already exists, just update the state
                let existingUser = UserItem(uid: userID, phoneNumber: userPhoneNumber)
                print("User already exists. Logging in.")
                self.authState.send(.loggedIn(existingUser))
            } else {
                // Пользователь не существует, создаем его и сохраняем в базе данных
                // User does not exist, create it and save to database
                let newUser = UserItem(uid: userID, phoneNumber: userPhoneNumber)
                try await saveUserInfoDatabase(user: newUser)
                print("New user created and saved to database.")
                self.authState.send(.loggedIn(newUser))
            }
        } catch {
            print("🔐 Failed to verify or create an account: \(error.localizedDescription)")
            throw AuthError.accountCreationFailed(error.localizedDescription)
        }
    }
    
    // Выходит из аккаунта
    // Logs out of the account
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

// MARK: - Extensions
// Перечисление ошибок для авторизации и создания пользователя
// Enumeration for authorization and creating a user
enum AuthError: Error {
    case accountCreationFailed(_ description: String)
    case failedToSaveUserInfo(_ description: String)
}

// Расширение для предоставления описания ошибок AuthError
// Extension for providing error descriptions for AuthError
extension AuthError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .accountCreationFailed(let description):
            return description
        case .failedToSaveUserInfo(let description):
            return description
        }
    }
}

extension AuthManager {
    
    // Создает словарь с данными нового юзера в БД
    // Creates a dictionary with new user data in the DB
    private func saveUserInfoDatabase(user: UserItem) async throws {
        do {
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
            
            // Сохраняем данные юзера в базе данных
            // Save user data to the database
            try await Database.database().reference().child("users").child(user.id).setValue(userDictionary)
        } catch {
            print("🔐 Failed to Save Created user info to Database: \(error.localizedDescription)")
            throw AuthError.failedToSaveUserInfo(error.localizedDescription)
        }
    }
    
    // Запрашивает данные юзера из БД
    // Requests user data from the database
    private func fetcCurrentUserInfo() {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        Database.database().reference().child("users").child(currentUid).observe(.value) {[weak self] snapshot in
            
            guard let userDict = snapshot.value as? [String: Any] else { return }
            let loggedInUser = UserItem(dictionary: userDict)
            self?.authState.send(.loggedIn(loggedInUser))
            print("🔐 Fetched user info: \(loggedInUser.phoneNumber)")
        } withCancel: { error in
            print("🔐 Failed to fetch user info: \(error.localizedDescription)")
        }
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

// Инициализирует UserItem из словаря
// Initializes UserItem from dictionary
extension UserItem {
    init(dictionary: [String: Any]) {
        self.uid = dictionary["uid"] as? String ?? ""
        self.phoneNumber = dictionary["phoneNumber"] as? String ?? ""
        self.username = dictionary["username"] as? String
        self.dateOfBirth = dictionary["dateOfBirth"] as? Date
        self.profileImageUrl = dictionary["profileImageUrl"] as? String ?? nil
    }
}

extension String {
    static let uid = "uid"
    static let phoneNumber = "phoneNumber"
    static let username = "username"
    static let dateOfBirth = "dateOfBirth"
    static let profileImageUrl = "profileImageUrl"
    
    var isValidPhoneNumber: Bool {
        let phoneNumberRegex = "^[0-9+]{0,1}+[0-9]{5,16}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneNumberRegex)
        let result =  phoneTest.evaluate(with: self)
        return result
    }
}
