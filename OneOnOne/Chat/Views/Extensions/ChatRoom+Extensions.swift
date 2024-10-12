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
        ToolbarItem(placement: .principal) {
            VStack(alignment: .center, spacing: 0) {
                Text("Username Test")
                    .font(.system(size: 17))
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
                    .lineLimit(1)
                
                Text("Last seen recently")
                    .font(.system(size: 12))
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
            }
        }
    }
}
