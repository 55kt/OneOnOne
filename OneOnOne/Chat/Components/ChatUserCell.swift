//
//  ChatUserCell.swift
//  OneOnOne
//
//  Created by Vlad on 5/10/24.
//

import SwiftUI

struct ChatUserCell: View {
    // MARK: - Properties
    let user: UserItem
    
    // MARK: - Body
    var body: some View {
        HStack(alignment: .top, spacing: 10) {
            DefaultUserAvatar(size: 60)
            
            VStack(alignment: .leading, spacing: 3) {
                titleTextView()
                lastMessagePreview()
            }
        }
    }
    
    // Имя пользователя
    // Username
    private func titleTextView() -> some View {
        HStack {
            Text(user.username ?? user.phoneNumber)
                .lineLimit(1)
                .bold()
            
            Spacer()
            
            Text("5:12 PM")
                .foregroundStyle(.gray)
                .font(.system(size: 15))
        }
    }
    
    // Preview последнего сообщения
    // Last message preview
    private func lastMessagePreview() -> some View {
        Text("Text message preview")
            .font(.system(size: 16))
            .lineLimit(2)
            .foregroundStyle(.gray)
    }
}

// MARK: - Preview
#Preview {
    ChatUserCell(user: .placeholder)
}
