//
//  ChatRoomView.swift
//  OneOnOne
//
//  Created by Vlad on 6/10/24.
//

import SwiftUI

struct ChatRoomView: View {
    
    // MARK: - Body
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(0..<15) { _ in
                    /*
                     Временная заглушка
                     Placeholder content
                     */
                    Text("PLACEHOLDER")
                        .font(.largeTitle)
                        .bold()
                        .frame(maxWidth: .infinity)
                        .frame(height: 200)
                        .foregroundStyle(.orange)
                        .background(Color.gray)
                }
            }
        }
        .toolbar(.hidden, for: .tabBar)
        .toolbar {
            trailingUserAvatar()
            toolbarUserInfo()
        }
        .toolbarTitleDisplayMode(.inline)
        .safeAreaInset(edge: .bottom) {
            TextInputArea()
        }
        .scrollIndicators(.hidden)
    }
}

// MARK: - Preview
#Preview {
    NavigationStack {
        ChatRoomView()
    }
}
