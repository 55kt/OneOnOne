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
                        .background(Color.orange)
                }
            }
        }
        .toolbar(.hidden, for: .tabBar)
        .toolbar {
            toolbarUsername()
            trailingUserAvatar()
        }
        .safeAreaInset(edge: .bottom) {
            TextInputArea()
                .background(Color(.systemBackground))
        }
    }
}

// MARK: - Preview
#Preview {
    NavigationStack {
        ChatRoomView()
    }
}
