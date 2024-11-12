//
//  ChatPartnerImage.swift
//  OneOnOne
//
//  Created by Vlad on 11/11/24.
//

import SwiftUI

struct ChatPartnerImage: View {
    // MARK: - Properties
    @Environment(\.dismiss) private var dismiss
    
    // MARK: - Body
    var body: some View {
        Image("borat")
            .resizable()
            .scaledToFill()
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.5)
            .clipped()
            .overlay(
                LinearGradient(
                    gradient: Gradient(colors: [.clear, .black.opacity(0.8)]),
                    startPoint: .center,
                    endPoint: .bottom
                )
                .frame(height: UIScreen.main.bounds.height * 0.25)
                .frame(maxHeight: .infinity, alignment: .bottom)
            )
    }
}

// MARK: - Preview
#Preview {
    ChatPartnerImage()
}
