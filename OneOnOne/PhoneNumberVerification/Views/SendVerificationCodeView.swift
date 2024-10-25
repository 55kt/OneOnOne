//
//  SendVerificationCodeView.swift
//  OneOnOne
//
//  Created by Vlad on 21/10/24.
//

import SwiftUI

struct SendVerificationCodeView: View {
    
    // MARK: - Properties
    @EnvironmentObject var authModel: AuthScreenModel
    @Binding var phoneNumberInput: String
    @Binding var selectedCountry: Country
    @State var action: () -> ()

    // MARK: - Body
    var body: some View {
        VStack(spacing: 20) {
            
            title()
            
            /*
             Поле ввода с выбором страны
             Input field with country selection
             */
            HStack {
                CountryPicker(selectedCountry: $selectedCountry)
                
                NumField(numPlaceholder: $authModel.phoneNumber, fieldDescription: "Phone number")
            }
            
            /*
             Кнопка подтверждения
             Confirmation button
             */
            VerificationButton(action: { action() }, title: "Send verification code")
                .disabled(authModel.disablePhoneNumberButton)
            
            Spacer()
        }
        .padding()
        .background(Color(.systemGroupedBackground).ignoresSafeArea())
    }
    
    // MARK: - Methods
    private func title() -> some View {
        Text("Enter your phone number")
            .font(.title2)
            .fontWeight(.bold)
            .foregroundColor(.appMessageText)
            .padding(.top, 40)
    }
}

// MARK: - Preview
#Preview {
    SendVerificationCodeView(phoneNumberInput: .constant(""), selectedCountry: .constant(Country.defaultCountry)) {}
        .environmentObject(AuthScreenModel())
}

