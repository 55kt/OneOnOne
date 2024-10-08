//
//  OneOnOneApp.swift
//  OneOnOne
//
//  Created by Vlad on 3/10/24.
//

import SwiftUI

@main
struct OneOnOneApp: App {
    
    @StateObject var themeManager = ThemeManager()
    
    var body: some Scene {
        WindowGroup {
            MainTabView()
                .environmentObject(themeManager)
                .preferredColorScheme(themeManager.toggleDarkMode ? .dark : .light)
        }
    }
}
