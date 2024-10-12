//
//  MessageListView.swift
//  OneOnOne
//
//  Created by Vlad on 12/10/24.
//

import SwiftUI

struct MessageListView: UIViewControllerRepresentable {
    
    /*
     Тип контроллера, который будет интегрирован в SwiftUI
     Type of controller that will be integrated into SwiftUI
     */
    typealias UIViewControllerType = MessageListController
    
    /*
     Метод создания контроллера.
     Вызывается SwiftUI один раз, когда нужно создать контроллер.
     
     Controller creation method.
     Called by SwiftUI once when a controller needs to be created.
     */
    func makeUIViewController(context: Context) -> MessageListController {
        let messageListController = MessageListController()
        return messageListController
    }
    
    func updateUIViewController(_ uiViewController: MessageListController, context: Context) {
        
    }
}

#Preview {
    MessageListView()
}
