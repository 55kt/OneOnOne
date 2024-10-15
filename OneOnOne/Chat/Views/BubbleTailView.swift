//
//  BubbleTailView.swift
//  OneOnOne
//
//  Created by Vlad on 12/10/24.
//

import SwiftUI

struct BubbleTailView: View {
    var direction: MessageDirection
    
    /*
     Цвет хвостиков
     Tails Color
     */
    private var backgroundColor: Color {
        return direction == .received ? Color.receivedMessage : Color.sentMessage
    }
    
    var body: some View {
        Image(direction == .sent ? .outgoingTail : .incomingTail)
            .renderingMode(.template)
            .resizable()
            .frame(width: 10, height: 10)
            .offset(y: 3)
            .foregroundStyle(backgroundColor)
    }
}

#Preview {
    ScrollView {
        BubbleTailView(direction: .sent)
        BubbleTailView(direction: .received)
    }
    .frame(maxWidth: .infinity)
    .background(Color.gray.opacity(0.2))
}
