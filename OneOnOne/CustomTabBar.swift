//
//  CustomTabBar.swift
//  OneOnOne
//
//  Created by Vlad on 4/10/24.
//

import SwiftUI

enum Tab: String, CaseIterable {
    case message, bubble, gearshape
}

struct CustomTabBar: View {
    // MARK: - Properties
    @Binding var selectedTab: Tab
    private var fillImage: String {
        selectedTab.rawValue + ".fill"
    }
    
    // MARK: - Body
    var body: some View {
        VStack {
            HStack {
                ForEach(Tab.allCases, id: \.rawValue) { tab in
                    Spacer()
                    Image(systemName: selectedTab == tab ? fillImage : tab.rawValue)
                        .scaleEffect(selectedTab == tab ? 1.25 : 1.0)
                        .foregroundStyle(selectedTab == tab ? .red : .gray)
                        .font(.system(size: 22))
                        .onTapGesture {
                            withAnimation(.easeIn(duration: 0.1)) {
                                selectedTab = tab
                            }
                        }
                    Spacer()
                }
            }
            .frame(width: nil, height: 60)
            .background(.gray.opacity(0.2))
            .cornerRadius(10)
            .padding()
        }
    }
}

// Пример использования CustomTabBar
struct ContentView: View {
    @State private var selectedTab: Tab = .message
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        ZStack {
            VStack {
                TabView(selection: $selectedTab) {
                    ForEach(Tab.allCases, id: \.rawValue) { tab in
                        HStack {
                            Image(systemName: tab.rawValue)
                            Text("\(tab.rawValue.capitalized)")
                                .bold()
                                .animation(nil, value: selectedTab)
                        }
                        .tag(tab)
                    }
                }
            }
            
            VStack {
                Spacer()
                CustomTabBar(selectedTab: $selectedTab)
            }
        }
    }
}

// MARK: - Preview
#Preview {
    ContentView()
}
