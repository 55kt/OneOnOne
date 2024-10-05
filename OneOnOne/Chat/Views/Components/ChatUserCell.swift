//
//  ChatUserCell.swift
//  OneOnOne
//
//  Created by Vlad on 5/10/24.
//

import SwiftUI

struct ChatUserCell: View {
    // MARK: - Body
    var body: some View {
        HStack(alignment: .top, spacing: 10) {
            Circle()
                .frame(width: 60, height: 60)
            
            VStack(alignment: .leading, spacing: 3) {
                titleTextView()
                lastMessagePreview()
            }
        }
    }
    
    /*
     Имя Юзера
     Username
     */
    private func titleTextView() -> some View {
        HStack {
            Text("Username here")
                .lineLimit(1)
                .bold()
            
            Spacer()
            
            Text("5:12 PM")
                .foregroundStyle(.gray)
                .font(.system(size: 15))
        }
    }
    
    /*
     Preview последнего сообщения
     Preview of the latest message
     */
    private func lastMessagePreview() -> some View {
        Text("Text message preview")
            .font(.system(size: 16))
            .lineLimit(2)
            .foregroundStyle(.gray)
    }
}

// MARK: - Preview
#Preview {
    ChatUserCell()
}
