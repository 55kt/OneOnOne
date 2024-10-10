//
//  ThemeManager.swift
//  OneOnOne
//
//  Created by Vlad on 8/10/24.
//

import SwiftUI

class ThemeManager: ObservableObject {
    @AppStorage("toggleDarkMode") var toggleDarkMode: Bool = false
    @AppStorage("activateDarkMode") var activateDarkMode: Bool = false
    
    /*
     Компонент кнопки для переключения темы
     Button component for switching theme
     */
    func themeButton() -> some View {
        Button {
            self.toggleDarkMode.toggle()
            self.activateDarkMode = self.toggleDarkMode
        } label: {
            Image(systemName: toggleDarkMode ? "sun.max.fill" : "moon.fill")
                .font(.title2)
                .foregroundStyle(toggleDarkMode ? Color.yellow : Color.primary)
                .symbolEffect(.bounce, value: toggleDarkMode)
                .frame(width: 50, height: 50)
                
        }
    }
}
