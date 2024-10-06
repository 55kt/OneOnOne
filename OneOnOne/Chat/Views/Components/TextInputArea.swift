//
//  TextInputArea.swift
//  OneOnOne
//
//  Created by Vlad on 6/10/24.
//

import SwiftUI

struct TextInputArea: View {
    // MARK: - Properties
    @State private var messageText: String = ""
    
    // MARK: - Body
    var body: some View {
        HStack(alignment: .bottom, spacing: 5) {
            imagePickerButton()
                .padding(3)
            audioRecorderButton()
            messageTextField()
            sendMessageButton()
        }
        .padding(.bottom)
        .padding(.horizontal, 8)
        .padding(.top, 10)
        .background(Color(.systemBackground))
    }
    
    // MARK: - Methods
    /*
     Функция поля воода сообщения
     Message field function
     */
    private func messageTextField() -> some View {
        TextField("", text: $messageText, axis: .vertical)
            .padding(5)
            .background(
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .fill(Color(.systemGray6))
            )
            .overlay(textViewBorder())
    }
    
    /*
     Контур воода сообщения
     Message input border
     */
    private func textViewBorder() -> some View {
        RoundedRectangle(cornerRadius: 10, style: .continuous)
            .stroke(Color(.systemGray3), lineWidth: 1)
    }
    
    /*
     Кнопка выбора изображения
     Image picker button
     */
    private func imagePickerButton() -> some View {
        Button {
            
        } label: {
            Image(systemName: "photo.on.rectangle.angled")
                .font(.system(size: 22))
        }
    }
    
    /*
     Кнопка записи аудио
     Audio recorder button
     */
    private func audioRecorderButton() -> some View {
        Button {
            
        } label: {
            Image(systemName: "mic.fill")
                .fontWeight(.heavy)
                .imageScale(.small)
                .foregroundStyle(.white)
                .padding(6)
                .background(.blue)
                .clipShape(Circle())
                .padding(.horizontal, 3)
        }
    }
    
    /*
     Кнопка отправки сообщения
     Send message button
     */
    private func sendMessageButton() -> some View {
        Button {
            
        } label: {
            Image(systemName: "arrow.up")
                .fontWeight(.heavy)
                .foregroundStyle(.white)
                .padding(6)
                .background(Color.blue)
                .clipShape(Circle())
        }
    }
}

// MARK: - Preview
#Preview {
    TextInputArea()
}
