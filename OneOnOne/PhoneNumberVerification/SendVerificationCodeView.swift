//
//  SendVerificationCodeView.swift
//  OneOnOne
//
//  Created by Vlad on 21/10/24.
//

import SwiftUI

struct SendVerificationCodeView: View {
    
    // MARK: - Properties
    @Binding var phoneNumberInput: String
    @State private var selectedCountry: Country = .defaultCountry // Структура Country для выбора страны
    @State var action: () -> ()
    
    // MARK: - Body
    var body: some View {
        VStack(spacing: 20) {
            
            // Заголовок
            Text("Enter your phone number")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.primary)
                .padding(.top, 40)
            
            // Поле ввода с выбором страны
            HStack {
                CountryPicker(selectedCountry: $selectedCountry) // Убираем рамки и фон
                TextField("Phone number", text: $phoneNumberInput)
                    .keyboardType(.phonePad)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray.opacity(0.4), lineWidth: 1)
                    )
            }
            .padding(.horizontal)
            
            // Кнопка подтверждения с анимацией
            Button(action: {
                withAnimation {
                    action()
                }
            }) {
                Text("Send Verification Code")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .leading, endPoint: .trailing))
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .shadow(color: Color.blue.opacity(0.4), radius: 5, x: 0, y: 5)
            }
            .padding(.horizontal)
            .padding(.top, 20)
            
            Spacer() // Для отступа внизу
        }
        .padding()
        .background(Color(.systemGroupedBackground).ignoresSafeArea()) // Фон экрана
    }
}

// Picker для выбора страны без рамок
struct CountryPicker: View {
    @Binding var selectedCountry: Country
    @State private var showCountryPicker = false
    
    var body: some View {
        HStack {
            Button(action: {
                showCountryPicker.toggle()
            }) {
                HStack {
                    Text(selectedCountry.flag)
                        .font(.system(size: 24))
                    
                    Text(selectedCountry.code)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                    
                    Image(systemName: "chevron.down")
                        .foregroundColor(.gray)
                        .padding(.leading, 5)
                }
                .padding(.horizontal)
            }
            .sheet(isPresented: $showCountryPicker) {
                CountrySelectionView(selectedCountry: $selectedCountry)
            }
        }
    }
}

// Mock представление для выбора страны
struct CountrySelectionView: View {
    @Binding var selectedCountry: Country
    @Environment(\.presentationMode) var presentationMode
    
    // Свойство поиска
    @State private var searchText = ""
    
    var body: some View {
        VStack {
            
            NavigationStack {
                // Список стран с учетом поиска
                List {
                    ForEach(filteredCountries, id: \.code) { country in
                        Button(action: {
                            selectedCountry = country
                            presentationMode.wrappedValue.dismiss()
                        }) {
                            HStack {
                                Text(country.flag)
                                Text(country.name)
                                Spacer()
                                Text(country.code)
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                }
                .searchable(text: $searchText, prompt: "Search country")
                .navigationTitle("Select Country")  // Установка заголовка
            }
        }
    }
    
    // Фильтрация стран на основе поиска
    var filteredCountries: [Country] {
        if searchText.isEmpty {
            return allCountries
        } else {
            return allCountries.filter {
                $0.name.lowercased().contains(searchText.lowercased()) || $0.code.contains(searchText)
            }
        }
    }
}

// Компонент поиска
struct SearchBar: View {
    @Binding var text: String
    
    var body: some View {
        HStack {
            TextField("Search country...", text: $text)
                .padding(8)
                .background(Color(.systemGray5))
                .cornerRadius(8)
                .overlay(
                    HStack {
                        Spacer()
                        if !text.isEmpty {
                            Button(action: {
                                text = ""
                            }) {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundColor(.gray)
                                    .padding(.trailing, 8)
                            }
                        }
                    }
                )
        }
    }
}

// MARK: - Preview
#Preview {
    SendVerificationCodeView(phoneNumberInput: .constant(""), action: {
        print("Send verification code tapped")
    })
}

