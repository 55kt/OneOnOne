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
        print("autoLogin: Checking current user...")
        if Auth.auth().currentUser == nil {
            print("autoLogin: No current user found, setting authState to .loggedOut")
            authState.send(.loggedOut)
        } else {
            print("autoLogin: Current user found, fetching user info")
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
                print("New user \(newUser.phoneNumber) created and saved to database.")
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
            print("logout: Attempting to sign out...")
            try Auth.auth().signOut()
            print("logout: Successfully signed out, updating authState to .loggedOut")
            DispatchQueue.main.async {
                self.authState.send(.loggedOut) // Обновляем состояние аутентификации
            }
        } catch {
            print("logout: Error signing out - \(error.localizedDescription)")
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
            try await FirebaseConstants.UserRef.child(user.id).setValue(userDictionary)
        } catch {
            print("🔐 Failed to Save Created user info to Database: \(error.localizedDescription)")
            throw AuthError.failedToSaveUserInfo(error.localizedDescription)
        }
    }
    
    // Запрашивает данные юзера из БД
    // Requests user data from the database
    private func fetcCurrentUserInfo() {
        guard let currentUid = Auth.auth().currentUser?.uid else {
            print("fetcCurrentUserInfo: No current user UID found, unable to fetch user info") // Сообщение, если UID отсутствует
            return
        }
        print("fetcCurrentUserInfo: Fetching data for UID \(currentUid)") // Сообщение для начала запроса данных

        FirebaseConstants.UserRef.child(currentUid).observeSingleEvent(of: .value) { [weak self] snapshot in
            guard let userDict = snapshot.value as? [String: Any] else {
                print("fetcCurrentUserInfo: No data found for UID \(currentUid), setting authState to .loggedOut") // Сообщение, если данных для пользователя нет
                self?.authState.send(.loggedOut)
                return
            }
            let loggedInUser = UserItem(dictionary: userDict)
            print("fetcCurrentUserInfo: Successfully fetched data for user \(loggedInUser.phoneNumber), setting authState to .loggedIn") // Сообщение, если данные успешно получены
            self?.authState.send(.loggedIn(loggedInUser))
        } withCancel: { error in
            print("fetcCurrentUserInfo: Failed to fetch user info with error: \(error.localizedDescription)") // Сообщение об ошибке
        }
    }
}


