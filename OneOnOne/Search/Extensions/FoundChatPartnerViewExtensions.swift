//
//  FoundChatPartnerViewExtensions.swift
//  OneOnOne
//
//  Created by Vlad on 11/11/24.
//

import Foundation
import SwiftUI

extension FoundChatPartnerView {
    
    // MARK: - Toolbar Items
    // Кнопка "сердечко" для отправки уведомления собеседнику о симпатии.
    // "Heart" button to send a notification to your interlocutor about your sympathy.
    @ToolbarContentBuilder
    func toolbarHeartButton() -> some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            Button(action: {
                // action
            }) {
                Image(systemName: "heart")
                    .font(.title2)
                    .foregroundColor(.white)
                    .padding(10)
                    .background(Circle().fill(Color.black.opacity(0.5)))
            }
        }
    }
    
    // Кнопка возврата - кнопка омтмены
    // Cancel Button
    @ToolbarContentBuilder
    func dismissToolbarButton() -> some ToolbarContent {
        ToolbarItem(placement: .topBarLeading) {
            Button(action: {
                // action
            }) {
                Image(systemName: "xmark")
                    .font(.title2)
                    .foregroundColor(.white)
                    .padding(10)
                    .background(Circle().fill(Color.black.opacity(0.5)))
            }
        }
    }
}

