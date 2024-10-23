//
//  VerificationButton.swift
//  OneOnOne
//
//  Created by Vlad on 21/10/24.
//

import SwiftUI

struct VerificationButton: View {
    
    // MARK: - Properties
    let action: () -> Void
    let title: String
    
    // MARK: - Body
    var body: some View {
        Button(action: {
            withAnimation {
                action()
            }
        }) {
            Text(title)
                .font(.headline)
                .frame(maxWidth: .infinity)
                .padding()
                .background(.receivedMessage)
                .foregroundColor(.appMessageText)
                .cornerRadius(10)
                .shadow(color: Color.blue.opacity(0.4), radius: 5, x: 0, y: 5)
        }
        .padding(.horizontal)
        .padding(.top, 20)
    }
}

#Preview {
    VerificationButton(action: {}, title: "Button title")
}
