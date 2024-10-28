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
    
    // MARK: - Body
    var body: some View {
        VStack(spacing: 20) {
            
            title()
            
            HStack {
                CountryPicker(selectedCountry: $authModel.selectedCountry)
                NumField(numPlaceholder: $authModel.phoneNumber, fieldDescription: "Phone number")
            }
            
            VerificationButton(action: {
                Task {
                    await authModel.handleSignUp()
                }
            }, title: "Submit")
                .disabled(authModel.disablePhoneNumberButton)
            
            Spacer()
        }
        .padding()
        .background(Color(.systemGroupedBackground).ignoresSafeArea())
    }
    
    /*
     Заголовок
     Title
     */
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
    SendVerificationCodeView()
        .environmentObject(AuthScreenModel())
}

