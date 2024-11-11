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
                    
                    ChatPartnerImageView()
                    
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
                
                // Раздел с информацией и кнопкой для начала чата
                VStack(spacing: 20) {
                    
                    Button(action: {
                        // Действие для кнопки начала чата
                    }) {
                        Text("Go Chat with Имя собеседника")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    .padding(.horizontal)
                }
                .padding()
                
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
