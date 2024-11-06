//
//  UserItem.swift
//  OneOnOne
//
//  Created by Vlad on 3/11/24.
//

import Foundation

struct UserItem: Identifiable, Hashable, Decodable {
    let uid: String
    let phoneNumber: String
    var username: String? = nil
    var dateOfBirth: Date? = nil
    var profileImageUrl: String? = nil
    
    var id: String {
        return uid
    }
    
    static let placeholder = UserItem(uid: "1", phoneNumber: "+306993244209", username: "Vlad", dateOfBirth: Date(), profileImageUrl: nil)
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
