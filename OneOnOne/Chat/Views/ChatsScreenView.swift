//
//  ChatsScreenView.swift
//  OneOnOne
//
//  Created by Vlad on 5/10/24.
//

import SwiftUI

struct ChatsScreenView: View {
    // MARK: - Properties
    // Временная переменная для текста в поисковом поле
    @State private var searchText: String = ""
    
    // MARK: - Body
    var body: some View {
        NavigationStack {
            
            /*
             Список чатов
             List of chats
             */
            List {
                ForEach(0..<20) { _ in
                    NavigationLink {
                        ChatRoomView()
                    } label: {
                        ChatUserCell()
                    }
                }
                inboxfooterView()
                    .listRowSeparator(.hidden)
            }
            .navigationTitle("Chats")
            .searchable(text: $searchText)
            .listStyle(.plain)
        }
    }
}

// MARK: - Preview
#Preview {
    ChatsScreenView()
}
