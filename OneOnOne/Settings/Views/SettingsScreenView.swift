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
    
    /*
     Кнопка выхода пользователя
     Log out button
     */
    private func logOutButton() -> some View {
        VStack {
            Button(action: {
                Task {
                    try? await AuthManager.shared.logout()
                }
            }) {
                Text("Log out")
                    .foregroundColor(.red)
                    .padding(8)
                    .background(Color.clear)
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.red.opacity(0.5), lineWidth: 1)
                    )
            }
            .frame(maxWidth: .infinity)
        }
    }
    
    /*
     Выход из аккаунта
     Log out from account
     */
    private func logOut() async throws {
        try Auth.auth().signOut()
    }
}

// MARK: - Preview
#Preview {
    SettingsScreenView()
        .environmentObject(ThemeManager())
}
