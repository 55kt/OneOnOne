//
//  SettingsScreenView.swift
//  OneOnOne
//
//  Created by Vlad on 5/10/24.
//

import SwiftUI

struct SettingsScreenView: View {
    // MARK: - Properties
    @EnvironmentObject var themeManager: ThemeManager
    @State var searchText: String = ""
    
    // MARK: - Body
    var body: some View {
        NavigationStack {
            List {
                
                SettingsUserCell()
                
                Section {
                    SettingsItemCell(cell: .broadCastLists)
                    SettingsItemCell(cell: .starredMessages)
                    SettingsItemCell(cell: .linkedDevices)
                }
                
                Section {
                    SettingsItemCell(cell: .account)
                    SettingsItemCell(cell: .privacy)
                    SettingsItemCell(cell: .chats)
                    SettingsItemCell(cell: .notifications)
                    SettingsItemCell(cell: .storage)
                }
                
                Section {
                    SettingsItemCell(cell: .help)
                    SettingsItemCell(cell: .tellFriend)
                }
            }
            .navigationTitle("Settings")
            .searchable(text: $searchText)
            
            /*
             Кнопка темы
             Theme button
             */
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    themeManager.themeButton()
                }
            }
        }
        .preferredColorScheme(themeManager.activateDarkMode ? .dark : .light)  // Смена цветовой схемы, Change color scheme
        
    }
}

// MARK: - Preview
#Preview {
    SettingsScreenView()
        .environmentObject(ThemeManager())
}
