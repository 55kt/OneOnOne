//
//  BubbleImageView.swift
//  OneOnOne
//
//  Created by Vlad on 14/10/24.
//

import SwiftUI

struct BubbleImageView: View {
    // MARK: - Properties
    let item: MessageItem
    
    // MARK: - Body
    var body: some View {
        HStack {
            if item.direction == .sent { Spacer() }
            
            HStack {    
                if item.direction == .sent { shareButton() }
                
                messageTextView()
                    .shadow(color: Color(.systemGray3).opacity(0.1), radius: 5, x: 0, y: 20)
                    .overlay {
                        mediaButton(for: item.type, direction: item.direction, action: {})
                    }
                
                if item.direction == .received { shareButton() }
            }
            
            if item.direction == .received { Spacer() }
        }
    }
    
    // MARK: - Methods
    
    /*
     Сообщение с содержимым картинки
     Message with picture content
     */
    private func messageTextView() -> some View {
        VStack(alignment: .leading, spacing: 0) {
            Image(.stubImage1)
                .resizable()
                .scaledToFill()
                .frame(width: 220, height: 180)
                .clipShape(
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                )
                .background {
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .fill(Color(.systemGray5))
                }
                .padding(5)
                .overlay(alignment: .bottomTrailing) {
                    TimeStampCapsuleText(item: item, time: "12:22")
                }
            
            Text(item.text)
                .padding([.horizontal, .bottom], 8)
                .frame(maxWidth: .infinity, alignment: .leading)
                .frame(width: 220)
                .foregroundStyle(.appMessageText)
        }
        .background(item.backgroundColor)
        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
        .applyTail(item.direction)
    }
}

// MARK: - Preview
#Preview {
    ScrollView {
        BubbleImageView(item: .sentPlaceholder)
        BubbleTextView(item: .receivedPlaceholder)
        BubbleTextView(item: .sentPlaceholder)
        BubbleImageView(item: .receivedPlaceholder)
        BubbleTextView(item: .sentPlaceholder)
        BubbleTextView(item: .receivedPlaceholder)
        BubbleImageView(item: .sentPlaceholder)
        BubbleImageView(item: .receivedPlaceholder)
    }
    .frame(maxWidth: .infinity)
    .padding(.horizontal)
    .background(Color.gray.opacity(0.3))
}
