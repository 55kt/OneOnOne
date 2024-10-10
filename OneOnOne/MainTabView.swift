//
//  MainTabView.swift
//  OneOnOne
//
//  Created by Vlad on 3/10/24.
//

import SwiftUI

struct MainTabView: View {
    
    // MARK: - Initializer
    init() {

    }
    
    // MARK: - Body
    var body: some View {
        TabView {
            ChatsScreenView()
                .tabItem {
                    Image(systemName: Tab.chats.icon)
                    Text(Tab.chats.title)
                }
            placeholderItemView("Search")
                .tabItem {
                    Image(systemName: Tab.search.icon)
                    Text(Tab.search.title)
                }
            SettingsScreenView()
                .tabItem {
                    Image(systemName: Tab.settings.icon)
                    Text(Tab.settings.title)
                }
        }
    }
}

// MARK: - Extensions
extension MainTabView {
    
    /*
     Временный PlaceHolder для тестинга TabBar
     Temporary PlaceHolder for testing TabBar
     */
    private func placeholderItemView(_ title: String) -> some View {
        ScrollView {
            VStack {
                ForEach(0..<120) { _ in
                    Text(title)
                        .font(.largeTitle)
                        .bold()
                        .frame(maxWidth: .infinity)
                        .frame(height: 120)
                        .background(.orange)
                }
            }
        }
    }
    
    // MARK: - TabView Enum
    private enum Tab: String {
        case chats, search, settings
        
        /*
         Переменная для оформления Text с заглавной буквы
         Variable for capitalizing Text
         */
        fileprivate var title: String {
            return rawValue.capitalized
        }
        
        fileprivate var icon: String {
            switch self {
            case .chats:
                return "bubble.middle.bottom"
            case .search:
                return "magnifyingglass"
            case .settings:
                return "gearshape.2.fill"
            }
        }
    }
}

// MARK: - Preview
#Preview {
    MainTabView()
        .environmentObject(ThemeManager())
}
