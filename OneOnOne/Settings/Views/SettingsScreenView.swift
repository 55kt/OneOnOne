//
//  SettingsScreenView.swift
//  OneOnOne
//
//  Created by Vlad on 5/10/24.
//

import SwiftUI
import Firebase
import FirebaseAuth

struct SettingsScreenView: View {
    // MARK: - Properties
    @EnvironmentObject var authModel: AuthScreenModel
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
                
                logOutButton()
            }
            .navigationTitle("Settings")
            .searchable(text: $searchText)
            
            // Кнопка изменения темы
            // Theme change button
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    themeManager.themeButton()
                }
            }
        }
        .preferredColorScheme(themeManager.activateDarkMode ? .dark : .light)
    }
    
    // Кнопка выхода пользователя
    // User log out button
    private func logOutButton() -> some View {
        HStack {
            Button(action: {
                Task {
                    try await AuthManager.shared.logout()
                }
            }) {
                Text("Sign Out")
                    .font(.system(size: 18, weight: .semibold, design: .default))
                    .foregroundColor(.red)
                    .underline()
            }
        }
        .frame(maxWidth: .infinity)
    }
    
    // Выход из аккаунта
    // Logs out of the account
    private func logOut() async throws {
        try Auth.auth().signOut()
    }
}

// MARK: - Preview
#Preview {
    SettingsScreenView()
        .environmentObject(ThemeManager())
}
