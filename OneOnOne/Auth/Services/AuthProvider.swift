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

enum AuthError: Error {
    case accountCreationFailed(_ description: String)
    case failedToSaveUserInfo(_ description: String)
}

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
        do {
            let credential = PhoneAuthProvider.provider().credential(withVerificationID: verificationID, verificationCode: verificationCode)
            let authResult = try await Auth.auth().signIn(with: credential)
            let newUser = UserItem(uid: authResult.user.uid, phoneNumber: authResult.user.phoneNumber ?? "")
            try await saveUserInfoDatabase(user: newUser)
            self.authState.send(.loggedIn(newUser))
        } catch {
            print("🔐 Failed to Create an account: (\(error.localizedDescription)")
            throw AuthError.accountCreationFailed(error.localizedDescription)
        }
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
    extension AuthManager {
        
        /*
         Создает словарь с данными нового юзера в БД
         Creates a dictionary with new user data in the DB
         */
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
                    
                    /*
                     Сохраняем юзера в БД
                     Saving the user in the DB
                     */
                    try await Database.database().reference().child("users").child(user.id).setValue(userDictionary)
                } catch {
                    print("🔐 Failed to Save Created user info to Database: \(error.localizedDescription)")
                    throw AuthError.failedToSaveUserInfo(error.localizedDescription)
                }
            }
        
        /*
         Запрашивает данные юзера из БД
         Requests user data from the DB
         */
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

/*
 Инициализирует UserItem из словаря
 Initializes UserItem from dictionary
 */
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
