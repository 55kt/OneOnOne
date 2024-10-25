//
//  VerificationButton.swift
//  OneOnOne
//
//  Created by Vlad on 21/10/24.
//

import SwiftUI

struct VerificationButton: View {
    
    // MARK: - Properties
    @Environment(\.isEnabled) private var isEnabled
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
                .background(backgroundColor)
                .foregroundColor(textColor)
                .cornerRadius(10)
                .shadow(color: Color.white.opacity(0.1), radius: 2, x: 0, y: 5)
        }
        .padding(.horizontal)
        .padding(.top, 20)
    }
    
    // MARK: - Methods
    /*
     Цвет фона кнопки
     Background color of the button
     */
    private var backgroundColor: Color {
        return isEnabled ? .receivedMessage : .receivedMessage.opacity(0.5)
    }
    
    /*
     Цвет текста
     Text color
     */
    private var textColor: Color {
        return isEnabled ? .appMessageText : .appMessageText.opacity(0.5)
    }
}

#Preview {
    VerificationButton(action: {}, title: "Button title")
}
