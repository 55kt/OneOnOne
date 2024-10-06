//
//  ChatRoom+Extensions.swift
//  OneOnOne
//
//  Created by Vlad on 6/10/24.
//

import SwiftUI

extension ChatRoomView {
    @ToolbarContentBuilder
     func trailingUserAvatar() -> some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            DefaultUserAvatar(size: 40)
        }
    }
    
    @ToolbarContentBuilder
     func toolbarUsername() -> some ToolbarContent {
         ToolbarItem(placement: .principal) {
            VStack {
                Text("Username")
                    .font(.body)
                    .fontWeight(.semibold)
                    .bold()
                
                Text("Last seen recently")
                    .font(.caption)
            }
        }
    }
}
