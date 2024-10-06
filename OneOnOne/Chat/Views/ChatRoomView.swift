//
//  ChatRoomView.swift
//  OneOnOne
//
//  Created by Vlad on 6/10/24.
//

import SwiftUI

struct ChatRoomView: View {
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(0..<15) { _ in
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

extension ChatRoomView {
    @ToolbarContentBuilder
    private func trailingUserAvatar() -> some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            HStack {
                ZStack {
                    Circle()
                        .fill(Color.gray.opacity(0.5))
                        .frame(width: 40, height: 40)
                    
                    Image(systemName: "person.fill")
                        .foregroundStyle(.white)
                        .font(.system(size: 20))
                }
                .padding(.bottom, 3)
            }
        }
    }
    
    @ToolbarContentBuilder
    private func toolbarUsername() -> some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            VStack {
                Text("Username")
                    .font(.body)
                    .fontWeight(.semibold)
                    .bold()
                
                Text("Last seen recently")
                    .font(.caption)
            }
            .padding(.trailing, 83)
        }
    }
}

#Preview {
    NavigationStack {
        ChatRoomView()
    }
}
