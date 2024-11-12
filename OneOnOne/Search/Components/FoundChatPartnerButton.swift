//
//  FoundChatPartnerButton.swift
//  OneOnOne
//
//  Created by Vlad on 11/11/24.
//

import SwiftUI

struct FoundChatPartnerButton: View {
    // MARK: - Properties
    var onSearch: () -> Void
    var buttonName: String
    var isDisabled: Bool
    
    // MARK: - Body
    var body: some View {
        Button(action: onSearch) {
            Text(buttonName)
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(isDisabled ? Color.gray : Color.blue)
                .cornerRadius(10)
                .shadow(color: .blue.opacity(0.3), radius: 10, x: 0, y: 5)
        }
        .padding(.horizontal)
        .disabled(isDisabled)
    }
}

// MARK: - Preview
#Preview {
    FoundChatPartnerButton(onSearch: {}, buttonName: "Button", isDisabled: false)
}
