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
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        themeManager.toggleDarkMode.toggle()
                        themeManager.activateDarkMode = themeManager.toggleDarkMode
                    } label: {
                        Image(systemName: themeManager.toggleDarkMode ? "sun.max.fill" : "moon.fill")
                            .font(.title2)
                            .foregroundStyle(themeManager.toggleDarkMode ? Color.yellow : Color.primary)
                            .foregroundStyle(Color.primary)
                            .symbolEffect(.bounce, value: themeManager.toggleDarkMode)
                            .frame(width: 40, height: 40)
                    }
                }
            }
        }
        .preferredColorScheme(themeManager.activateDarkMode ? .dark : .light)
    }
}

// MARK: - Preview
#Preview {
    SettingsScreenView()
        .environmentObject(ThemeManager())
}
