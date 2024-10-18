//
//  mediaButton.swift
//  OneOnOne
//
//  Created by Vlad on 17/10/24.
//

import SwiftUI

/*
 Функция для создания кнопки на основе типа сообщения
 Function to create a button based on post type
 */
func mediaButton(for messageType: MessageType, direction: MessageDirection, action: @escaping () -> Void) -> some View {
    switch messageType {
    case .video:
        return AnyView(
            Image(systemName: "play.fill")
                .padding()
                .imageScale(.large)
                .foregroundStyle(.gray)
                .background(.thinMaterial)
                .clipShape(Circle())
                .padding(.bottom, 50)
        )
        
    case .audio:
        return AnyView(
            Button(action: action) {
                Image(systemName: "play.fill")
                    .padding(10)
                    .background(direction == .received ? .black.opacity(0.3) : .white.opacity(0.5))
                    .clipShape(Circle())
                    .foregroundStyle(direction == .received ? .white : .black)
            }
        )
        
    default:
        return AnyView(EmptyView())
    }
}

