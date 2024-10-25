//
//  ConfirmVerifyCodeView.swift
//  OneOnOne
//
//  Created by Vlad on 21/10/24.
//

import SwiftUI

struct ConfirmVerifyCodeView: View {
    
    // MARK: - Properties
    @EnvironmentObject var authModel: AuthScreenModel
    @Binding var verificationCode: String
    @State var action: () -> ()
    
    // MARK: - Body
    var body: some View {
        VStack(spacing: 20) {
            
            title()
            /*
             Поле воода кода верификации
             Verification code input area
             */
            NumField(numPlaceholder: $authModel.verificationCode, fieldDescription: "Verification code")
            
            /*
             Кнопка действия подтверждения кода верификации
             Verification code confirmation action button
             */
            VerificationButton(action: { action() }, title: "Verify code")
                .disabled(authModel.disableConfirmButton)
            Spacer()
        }
        .padding()
        .background(Color(.systemGroupedBackground).ignoresSafeArea())
        
    }
    
    // MARK: - Meyhods
    private func title() -> some View {
        Text("Enter verification code")
            .font(.title2)
            .fontWeight(.bold)
            .foregroundColor(.primary)
            .padding(.top, 40)
    }
}

// MARK: - Preview
#Preview {
    ConfirmVerifyCodeView(verificationCode: .constant("")) {}
        .environmentObject(AuthScreenModel())
}
