//
//  ChatsScreenView+Extensions.swift
//  OneOnOne
//
//  Created by Vlad on 5/10/24.
//

import SwiftUI

extension ChatsScreenView {
    @ToolbarContentBuilder
    
    /*
     Кнопка левого меню
     Left menu button
     */
    func leadingNavItems() -> some ToolbarContent {
        ToolbarItem(placement: .topBarLeading) {
            Menu {
                Button {
                    // Some action
                } label: {
                    Label("Select Chats", systemImage: "checkmark.circle")
                }
            } label: {
                Image(systemName: "ellipsis.circle")
                    .foregroundStyle(.orange)
            }
        }
    }
    
    /*
     Ячейка архивированных чатов
     Archived chat box
     */
    func archiveButton() -> some View {
        Button {
            // Some action
        } label: {
            Label("Archived", systemImage: "archivebox.fill")
                .bold()
                .padding()
                .foregroundStyle(.green)
            
        }
    }
    
    /*
     Нижняя ссылка под ячейками чата
     Bottom link under chat cells
     */
    func inboxfooterView() -> some View {
        HStack {
            Image(systemName: "lock.fill")
            
            (
                Text("Your personal message are ")
                +
                Text("end-to-end encrypted")
                    .foregroundStyle(.blue)
            )
        }
        .foregroundStyle(.gray)
        .font(.caption)
        .padding(.horizontal)
    }
}
