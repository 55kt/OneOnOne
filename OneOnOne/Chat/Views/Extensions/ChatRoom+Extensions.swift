//
//  ChatRoom+Extensions.swift
//  OneOnOne
//
//  Created by Vlad on 6/10/24.
//

import SwiftUI

/*
 Имя и информация пользователя
 User name and information
 */

extension ChatRoomView {
    @ToolbarContentBuilder
     func trailingUserAvatar() -> some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            DefaultUserAvatar(size: 40)
        }
    }
    
    @ToolbarContentBuilder
     func toolbarUserInfo() -> some ToolbarContent {
         ToolbarItem(placement: .topBarTrailing) {
            VStack {
                Text("Username")
                    .font(.body)
                    .fontWeight(.semibold)
                    .bold()
                
                Text("Last seen recently")
                    .font(.caption)
            }
            .frame(maxWidth: .infinity, alignment: .center)
        }
    }
}
