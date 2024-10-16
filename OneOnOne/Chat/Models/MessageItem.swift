//
//  MessageItem.swift
//  OneOnOne
//
//  Created by Vlad on 12/10/24.
//

import Foundation
import SwiftUI

struct MessageItem: Identifiable {
    
    // MARK: - Properties for messages
    let id = UUID().uuidString
    let text: String
    let type: MessageType
    let direction: MessageDirection
    
    /*
     Заполнители для предварительного просмотра
     Preview Placeholders
     */
    static let sentPlaceholder = MessageItem(text: "Hello, World!, I'm sent message placeholder", type: .text, direction: .sent)
    static let receivedPlaceholder = MessageItem(text: "Hello, World!, I'm received message placeholder", type: .text, direction: .received)
    
    /*
     Выравнивает еллементы по краям экрана в зависимости от сообщения
     Aligns elements to the edges of the screen depending on the message
     */
    var alignment: Alignment {
        return direction == .received ? .leading : .trailing
    }
    
    /*
     Прижимает вторичный елемент к краю экрана ( Время отправки )
     Presses the secondary element to the edge of the screen (Send Time)
     */
    var horizontalAlignment: HorizontalAlignment {
        return direction == .received ? .leading : .trailing
    }
    
    /*
     Цвет сообщения
     Message Color
     */
    var backgroundColor: Color {
        return direction == .sent ? Color.sentMessage : Color.receivedMessage
    }
    
    static let stubMessages: [MessageItem] = [
        MessageItem(text: "Hello, World! This is text type Message stub", type: .text, direction: .received),
        MessageItem(text: "Hello, World! This is photo type Message stub", type: .photo, direction: .sent),
        MessageItem(text: "Hello, World! This is video type Message stub", type: .video, direction: .received),
        MessageItem(text: "", type: .audio, direction: .received)
    ]
}

enum MessageType {
    case text, photo, video, audio
}

/*
 Направление сообщения
 Message Direction
 */
enum MessageDirection {
    case sent, received
    
    /*
     Возвращает массив сообщений
     Returns an array of messages
     */
    static var random: MessageDirection {
        return [MessageDirection.sent, .received].randomElement() ?? .sent
    }
}
