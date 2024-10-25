//
//  AuthScreenModel.swift
//  OneOnOne
//
//  Created by Vlad on 24/10/24.
//

import Foundation

final class AuthScreenModel: ObservableObject {
    
    @Published var phoneNumber: String = ""
    @Published var verificationCode: String = ""
    @Published var selectedCountry: Country = .defaultCountry
    @Published var isPhoneNumberCorrect: Bool = false
    
    var disablePhoneNumberButton: Bool {
        return phoneNumber.isEmpty
    }
    
    var disableConfirmButton: Bool {
        return verificationCode.isEmpty
    }
}
