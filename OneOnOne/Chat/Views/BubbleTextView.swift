//
//  BubbleTextView.swift
//  OneOnOne
//
//  Created by Vlad on 12/10/24.
//

import SwiftUI

struct BubbleTextView: View {
    // MARK: - Properties
    let item: MessageItem // Вызов настроек сообщений : Calling message settings
    
    // MARK: - Body
    var body: some View {
        VStack(alignment: item.horizontalAlignment, spacing: 3) {
            Text("Hello, World! How are you feeling ?")
                .padding(10)
                .background(item.backgroundColor)
                .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                .applyTail(item.direction)
                .foregroundStyle(.appMessageText)
            
            TimeStampText(item: item, time: "15:23")
        }
        .shadow(color: Color(.systemGray3).opacity(0.1), radius: 5, x: 0, y: 20)
        .frame(maxWidth: .infinity, alignment: item.alignment)
        .padding(.leading, item.direction == .received ? 1 : 100)
        .padding(.trailing, item.direction == .received ? 100 : 5)
    }
    
    // MARK: - Methods
    
}

// MARK: - Preview
#Preview {
    ScrollView {
        BubbleTextView(item: .sentPlaceholder)
        BubbleTextView(item: .receivedPlaceholder)
        BubbleTextView(item: .sentPlaceholder)
        BubbleTextView(item: .receivedPlaceholder)
        BubbleTextView(item: .sentPlaceholder)
        BubbleTextView(item: .receivedPlaceholder)
        BubbleTextView(item: .sentPlaceholder)
        BubbleTextView(item: .receivedPlaceholder)
    }
    .frame(maxWidth: .infinity)
    .background(Color.gray.opacity(0.3))
}
