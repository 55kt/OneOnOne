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
    
    // MARK: - Body
    var body: some View {
        VStack(spacing: 20) {
            
            title()
            
            NumField(numPlaceholder: $authModel.verificationCode, fieldDescription: "Verification code")
            
            VerificationButton(action: {
                Task {
                    await authModel.verifyCodeAndLogin()
                }
            }, title: "Verify code")
                .disabled(authModel.disableConfirmButton)
            
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
        Text("Enter verification code")
            .font(.title2)
            .fontWeight(.bold)
            .foregroundColor(.primary)
            .padding(.top, 40)
    }
}

// MARK: - Preview
#Preview {
    ConfirmVerifyCodeView()
        .environmentObject(AuthScreenModel())
}
