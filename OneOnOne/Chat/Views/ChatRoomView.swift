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
        MessageListView()
            .edgesIgnoringSafeArea(.bottom) 
        .toolbar(.hidden, for: .tabBar)
        .toolbar {
            trailingUserAvatar()
            toolbarUserInfo()
        }
        .navigationBarTitleDisplayMode(.inline)
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
