//
//  TimeStampText.swift
//  OneOnOne
//
//  Created by Vlad on 16/10/24.
//

import SwiftUI

struct TimeStampText: View {
    // MARK: - Properties
    let item: MessageItem
    let time: String
    
    // MARK: - Body
    var body: some View {
        HStack {
            Text(time)
                .font(.system(size: 13))
                .foregroundStyle(.gray)
            
            /*
             Иконка(Просмотренного полученного сообщения) - Галочка
             Icon (Viewed received message) - Check mark
             */
            if item.direction == .sent {
                Image(.seen)
                    .resizable()
                    .renderingMode(.template)
                    .frame(width: 15, height: 15)
                    .foregroundStyle(.seenMark)
            }
        }
    }
}

// MARK: - Preview
#Preview {
    TimeStampText(item: .sentPlaceholder, time: "11:01")
        .preferredColorScheme(.dark)
}
