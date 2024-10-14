//
//  CustomModifiers.swift
//  OneOnOne
//
//  Created by Vlad on 14/10/24.
//

import SwiftUI

private struct BubbleTailModifier: ViewModifier {
    // MARK: - Properties
    var direction: MessageDirection
    
    /*
     Функция наложения хвостика на сообщение
     Function of overlay a tail to a message
     */
    func body(content: Content) -> some View {
        content.overlay(alignment: direction == .received ? .bottomLeading : .bottomTrailing) {
            BubbleTailView(direction: direction)
        }
    }
}

// MARK: - Extensions
extension View {
    func applyTail(_ direction: MessageDirection) -> some View {
        self.modifier(BubbleTailModifier(direction: direction))
    }
}
