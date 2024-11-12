//
//  FoundChatPartnerView.swift
//  OneOnOne
//
//  Created by Vlad on 8/11/24.
//

import SwiftUI

struct FoundChatPartnerView: View {
    // MARK: - Properties
    let user: UserItem
    
    // MARK: - Body
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                ZStack(alignment: .top) {
                    
                    ChatPartnerImage()
                    
                    VStack {
                        
                        Spacer()
                        
                        // Имя пользователя и статус прибывания
                        // Username and arrival status
                        VStack(alignment: .leading, spacing: 4) {
                            Text(user.username ?? "Username")
                                .font(.largeTitle)
                                .bold()
                                .foregroundColor(.white)
                            Text("last seen recently")
                                .font(.subheadline)
                                .foregroundColor(.white.opacity(0.7))
                        }
                        .padding(.horizontal)
                        .padding(.bottom, 20)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .frame(height: UIScreen.main.bounds.height * 0.5, alignment: .top)
                }
                .toolbar {
                    toolbarHeartButton()
                    dismissToolbarButton()
                }
                
                // Кнопка начала чата с найденным собеседником
                // Button to start a chat with the found partner
                FoundChatPartnerButton(onSearch: {
                    // action
                }, buttonName: "Start chat with \(user.username ?? "User")", isDisabled: false)
                .padding(.top, 120)
                
                Spacer()
            }
            .ignoresSafeArea()
        }
    }
}

// MARK: - Preview
#Preview {
    FoundChatPartnerView(user: .placeholder)
}
