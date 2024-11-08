//
//  FoundChatPartnerView.swift
//  OneOnOne
//
//  Created by Vlad on 8/11/24.
//

import SwiftUI

struct FoundChatPartnerView: View {
    var body: some View {
        VStack(spacing: 0) {
            ZStack(alignment: .top) {
                // Основное изображение профиля
                Image("borat") // Убедитесь, что "profile_photo" находится в Assets
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.5)
                    .clipped()
                    .overlay(
                        // Полупрозрачный градиент в нижней части изображения
                        LinearGradient(
                            gradient: Gradient(colors: [.clear, .black.opacity(0.8)]),
                            startPoint: .center,
                            endPoint: .bottom
                        )
                        .frame(height: UIScreen.main.bounds.height * 0.25)
                        .frame(maxHeight: .infinity, alignment: .bottom)
                    )
                
                VStack {
                    // Верхняя панель с кнопками
                    HStack {
                        Button(action: {
                            // Действие кнопки "Назад"
                        }) {
                            Image(systemName: "arrow.left")
                                .font(.title2)
                                .foregroundColor(.white)
                                .padding(10)
                                .background(Circle().fill(Color.black.opacity(0.5)))
                        }
                        
                        Spacer()
                        
                        Button(action: {
                            // Действие кнопки "Лайк"
                        }) {
                            Image(systemName: "heart")
                                .font(.title2)
                                .foregroundColor(.white)
                                .padding(10)
                                .background(Circle().fill(Color.black.opacity(0.5)))
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top, 50) // Учитываем безопасную зону сверху
                    
                    Spacer()
                    
                    // Текст с именем и статусом
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Имя собеседника")
                            .font(.largeTitle)
                            .bold()
                            .foregroundColor(.white)
                        Text("last seen recently")
                            .font(.subheadline)
                            .foregroundColor(.white.opacity(0.7))
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 20)
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .frame(height: UIScreen.main.bounds.height * 0.5, alignment: .top)
            }
            
            // Раздел с информацией и кнопкой для начала чата
            VStack(spacing: 20) {
                Text("Имя собеседника")
                    .font(.title)
                    .bold()
                
                Button(action: {
                    // Действие для кнопки начала чата
                }) {
                    Text("Go Chat with Имя собеседника")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding(.horizontal)
            }
            .padding()
            
            Spacer()
        }
        .ignoresSafeArea()
    }
}

#Preview {
    FoundChatPartnerView()
}

#Preview {
    FoundChatPartnerView()
}
