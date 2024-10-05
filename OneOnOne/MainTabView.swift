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
//        makeTabBarOpaque()
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
            placeholderItemView("Settings")
                .tabItem {
                    Image(systemName: Tab.settings.icon)
                    Text(Tab.settings.title)
                }
        }
        .accentColor(.orange)
    }
    
    // Функция которая делает TabBar постоянно непрозрачным
    private func makeTabBarOpaque() {
        let apperance = UITabBarAppearance()
        apperance.configureWithOpaqueBackground()
        UITabBar.appearance().standardAppearance = apperance
        UITabBar.appearance().scrollEdgeAppearance = apperance
    }
}

// MARK: - Extensions
extension MainTabView {
    
    // Временный PlaceHolder для тестинга TabBar
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
        
        // Переменная для оформления Text с заглавной буквы
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
}
