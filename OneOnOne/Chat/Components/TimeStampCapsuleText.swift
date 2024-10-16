//
//  TimeStampCapsuleText.swift
//  OneOnOne
//
//  Created by Vlad on 16/10/24.
//

import SwiftUI

struct TimeStampCapsuleText: View {
    // MARK: - Properties
    let item: MessageItem
    let time: String
    
    // MARK: - Body
    var body: some View {
        HStack {
            Text(time)
                .font(.system(size: 12))
            
            if item.direction == .sent {
                Image(.seen)
                    .resizable()
                    .renderingMode(.template)
                    .frame(width: 15, height: 15)
                    .foregroundStyle(.seenMark)
            }
        }
        .padding(.vertical, 2.5)
        .padding(.horizontal, 8)
        .foregroundStyle(.white)
        .background(Color(.systemFill))
        .clipShape(Capsule())
        .padding(12)
    }
}

// MARK: - Previews
#Preview {
    TimeStampCapsuleText(item: .sentPlaceholder, time: "14:08")
        .preferredColorScheme(.dark)
}
