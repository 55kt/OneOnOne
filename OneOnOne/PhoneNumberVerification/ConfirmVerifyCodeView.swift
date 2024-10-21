//
//  ConfirmVerifyCodeView.swift
//  OneOnOne
//
//  Created by Vlad on 21/10/24.
//

import SwiftUI

struct ConfirmVerifyCodeView: View {
    
    // MARK: - Properties
    @Binding var verificationCode: String
    @State var action: () -> ()
    
    // MARK: - Body
    var body: some View {
        
        /*
         Поле воода кода верификации
         Verification code input area
         */
        TextField("Verification code", text: $verificationCode)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding()
        
        /*
         Кнопка действия подтверждения кода верификации
         Verification code confirmation action button
         */
        Button {
            action()
        } label: {
            Text("Verify Code")
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)
        }
    }
}

#Preview {
    ConfirmVerifyCodeView(verificationCode: .constant("")) {}
}
