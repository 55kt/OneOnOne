//
//  SearchPartnerView.swift
//  OneOnOne
//
//  Created by Vlad on 7/11/24.
//

import SwiftUI

struct SearchPartnerView: View {
    // MARK: - Properties
    @State private var searchQuery: String = ""
    @State private var tags: [String] = []
    @State private var searchResults: [UserItem] = []
    @State private var isSearching: Bool = false
    
    @State private var selectedGender: Gender = .any
    @State private var ageRange: ClosedRange<Double> = 18.0...60.0
    
    @State private var minAge: Double = 18
    @State private var maxAge: Double = 60
    
    // MARK: - Body
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                // Поле для ввода тега
                HStack {
                    TextField("Введите тэг", text: $searchQuery)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(color: .gray.opacity(0.2), radius: 5, x: 0, y: 5)
                    
                    Button(action: addTag) {
                        Image(systemName: "plus.circle.fill")
                            .foregroundColor(.blue)
                            .font(.system(size: 24))
                            .padding()
                    }
                    .disabled(searchQuery.isEmpty)
                }
                .padding(.horizontal)
                
                // Отображение добавленных тэгов
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 10) {
                        ForEach(tags, id: \.self) { tag in
                            TagView(tag: tag, onRemove: removeTag)
                        }
                    }
                    .padding(.horizontal)
                }
                
                // Выбор пола
                VStack(alignment: .leading) {
                    Text("Пол собеседника")
                        .font(.headline)
                        .foregroundColor(.gray)
                        .padding(.leading)
                    
                    Picker("Пол собеседника", selection: $selectedGender) {
                        ForEach(Gender.allCases, id: \.self) { gender in
                            Text(gender.rawValue.capitalized)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding(.horizontal)
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(color: .gray.opacity(0.2), radius: 5, x: 0, y: 5)
                }
                
                // Возрастной диапазон
                VStack(alignment: .leading, spacing: 10) {
                    Text("Возрастной диапазон")
                        .font(.headline)
                        .foregroundColor(.gray)
                        .padding(.leading)
                    
                    Text("Выбранный возраст: \(Int(minAge)) - \(Int(maxAge))")
                        .font(.subheadline)
                        .bold()
                        .padding(.horizontal)
                    
                    Slider(value: $minAge, in: 18...60, step: 1.0)
                        .accentColor(.blue)
                        .padding(.horizontal)
                    
                    Slider(value: $maxAge, in: 18...60, step: 1.0)
                        .accentColor(.blue)
                        .padding(.horizontal)
                }
                
                NavigationLink {
                    FoundChatPartnerView(user: .placeholder)
                } label: {
                    Button(action: performSearch) {
                        Text("Найти собеседника")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .cornerRadius(10)
                            .shadow(color: .blue.opacity(0.3), radius: 10, x: 0, y: 5)
                    }
                    .padding(.horizontal)
                    .disabled(tags.isEmpty)
                }
                
                Divider().padding(.horizontal)
                
                // Результаты поиска
                if isSearching {
                    ProgressView("Идет поиск...")
                        .padding()
                } else {
                    List(searchResults, id: \.uid) { user in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(user.username ?? "Пользователь без имени")
                                    .font(.headline)
                                    .foregroundColor(.primary)
                                Text(user.phoneNumber)
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(color: .gray.opacity(0.1), radius: 5, x: 0, y: 5)
                    }
                    .listStyle(PlainListStyle())
                }
            }
            .navigationTitle("Поиск собеседника")
            .padding(.top)
            .background(Color(UIColor.systemGroupedBackground))
            .edgesIgnoringSafeArea(.bottom)
        }
    }
    
    // MARK: - Methods
    
    private func addTag() {
        if !searchQuery.isEmpty && !tags.contains(searchQuery) {
            tags.append(searchQuery)
            searchQuery = ""
        }
    }
    
    private func removeTag(_ tag: String) {
        tags.removeAll { $0 == tag }
    }
    
    private func performSearch() {
        guard !tags.isEmpty else { return }
        
        isSearching = true
        
        // Имитируем задержку для поиска (например, вызов API)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            // Пример поиска по тэгам и фильтрации по полу и возрасту
            searchResults = mockSearch(tags: tags, gender: selectedGender, ageRange: ageRange)
            
            isSearching = false
        }
    }
    
    // Пример функции для имитации поиска
    private func mockSearch(tags: [String], gender: Gender, ageRange: ClosedRange<Double>) -> [UserItem] {
        let mockData: [UserItem] = [
            UserItem(uid: "1", phoneNumber: "+123456789", username: "Тест Пользователь", dateOfBirth: nil, profileImageUrl: nil),
            UserItem(uid: "2", phoneNumber: "+987654321", username: "Другой Пользователь", dateOfBirth: nil, profileImageUrl: nil)
        ]
        
        // Пример фильтрации по тэгам, полу и возрасту (может быть более сложной)
        return mockData.filter { user in
            tags.contains { tag in
                user.username?.lowercased().contains(tag.lowercased()) ?? false
            }
        }
    }
}

// MARK: - Вспомогательный View для отображения тэгов
struct TagView: View {
    let tag: String
    var onRemove: (String) -> Void
    
    var body: some View {
        HStack {
            Text(tag)
                .padding(.horizontal, 10)
                .padding(.vertical, 5)
                .background(Color.blue.opacity(0.2))
                .foregroundColor(.blue)
                .font(.subheadline)
                .cornerRadius(15)
            
            Button(action: { onRemove(tag) }) {
                Image(systemName: "xmark.circle.fill")
                    .foregroundColor(.blue)
            }
        }
        .padding(5)
        .background(Color.blue.opacity(0.1))
        .cornerRadius(20)
    }
}

// MARK: - Гендерные Опции
enum Gender: String, CaseIterable {
    case any = "Любой"
    case male = "Мужской"
    case female = "Женский"
}

// MARK: - Preview
#Preview {
    NavigationView {
        SearchPartnerView()
    }
}
