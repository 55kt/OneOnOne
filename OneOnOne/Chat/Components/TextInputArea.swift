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
        HStack() {
            imagePickerButton()
                .padding(3)
            messageTextField()
            Spacer()
            
            /*
             Анимация между кнопками audioRecorderButton и sendMessageButton
             когда поле воода сообщения заполнено
             Animation between audioRecorderButton and sendMessageButton
             when the message field is full
             */
            (messageText.isEmpty ? AnyView(audioRecorderButton()) : AnyView(sendMessageButton()))
                .symbolEffect(.bounce, value: messageText.isEmpty)
                .frame(width: 40, height: 40)
        }
        .padding(.horizontal, 8)
        .padding(.top, 8)
        .background(Color.appBackground)
    }
    
    // MARK: - Methods
    /*
     Функция поля воода сообщения
     Message field function
     */
    private func messageTextField() -> some View {
        TextField("Message", text: $messageText, axis: .vertical)
            .padding(8)
            .background(
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .fill(.appBlackWhite)
            )
            .overlay(textViewBorder())
    }
    
    /*
     Контур воода сообщения
     Message input border
     */
    private func textViewBorder() -> some View {
        RoundedRectangle(cornerRadius: 16, style: .continuous)
            .stroke(Color(.systemGray3), lineWidth: 0.2)
    }
    
    /*
     Кнопка выбора изображения
     Image picker button
     */
    private func imagePickerButton() -> some View {
        Button {
            
        } label: {
            Image(systemName: "photo")
                .foregroundStyle(.appButton)
                .font(.system(size: 30))
        }
    }
    
    /*
     Кнопка записи аудио
     Audio recorder button
     */
    private func audioRecorderButton() -> some View {
        Button {
            
        } label: {
            Image(systemName: "mic")
                .foregroundStyle(.appButton)
                .font(.system(size: 27))
        }
    }
    
    /*
     Кнопка отправки сообщения
     Send message button
     */
    private func sendMessageButton() -> some View {
        Button {
            
        } label: {
            Image(systemName: "location.north.circle")
                .foregroundStyle(.appButton)
                .font(.system(size: 33))
        }
    }
}

// MARK: - Preview
#Preview {
    TextInputArea()
}
