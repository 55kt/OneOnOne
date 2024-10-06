//
//  DefaultUserAvatar.swift
//  OneOnOne
//
//  Created by Vlad on 6/10/24.
//

import SwiftUI

import SwiftUI

// Глобальный компонент для аватара пользователя с настраиваемым размером
struct DefaultUserAvatar: View {
    // Параметр для настройки размера круга
    var size: CGFloat
    
    var body: some View {
        HStack {
            ZStack {
                // Круг с настраиваемым размером
                Circle()
                    .fill(Color.gray.opacity(0.5))
                    .frame(width: size, height: size)
                
                // Иконка с размером, зависящим от размера круга
                Image(systemName: "person.fill")
                    .foregroundStyle(.white)
                    .font(.system(size: size * 0.5)) // Иконка занимает половину размера круга
            }
            .padding(.bottom, 3)
        }
    }
}

#Preview {
    // Пример использования компонента с разными размерами
    VStack {
        DefaultUserAvatar(size: 40) // Круг с диаметром 40
        DefaultUserAvatar(size: 60) // Круг с диаметром 60
        DefaultUserAvatar(size: 100) // Круг с диаметром 100
    }
}
