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
    @State private var selectedCountry: Country = .defaultCountry // Структура Country будет для выбора страны
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
            
            // Выбор страны с кодом
            HStack {
                CountryPicker(selectedCountry: $selectedCountry) // Добавляем picker для выбора страны
                    .padding(.leading)
                
                TextField("Phone number", text: $phoneNumberInput)
                    .keyboardType(.phonePad)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray.opacity(0.4), lineWidth: 1)
                    )
                    .padding(.trailing)
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

// Пример структуры для страны
struct Country {
    let name: String
    let code: String
    let flag: String
    
    static var defaultCountry: Country {
        return Country(name: "United States", code: "+1", flag: "🇺🇸")
    }
}

// Picker для выбора страны
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
                .frame(height: 50)
                .background(Color(.secondarySystemBackground))
                .cornerRadius(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray.opacity(0.4), lineWidth: 1)
                )
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
    
    var body: some View {
        List {
            Button(action: {
                selectedCountry = Country(name: "United States", code: "+1", flag: "🇺🇸")
                presentationMode.wrappedValue.dismiss()
            }) {
                HStack {
                    Text("🇺🇸")
                    Text("United States")
                    Spacer()
                    Text("+1")
                        .foregroundColor(.gray)
                }
            }
            
            Button(action: {
                selectedCountry = Country(name: "Canada", code: "+1", flag: "🇨🇦")
                presentationMode.wrappedValue.dismiss()
            }) {
                HStack {
                    Text("🇨🇦")
                    Text("Canada")
                    Spacer()
                    Text("+1")
                        .foregroundColor(.gray)
                }
            }
            
            Button(action: {
                selectedCountry = Country(name: "United Kingdom", code: "+44", flag: "🇬🇧")
                presentationMode.wrappedValue.dismiss()
            }) {
                HStack {
                    Text("🇬🇧")
                    Text("United Kingdom")
                    Spacer()
                    Text("+44")
                        .foregroundColor(.gray)
                }
            }
        }
        .navigationTitle("Select Country")
    }
}

// MARK: - Preview
#Preview {
    SendVerificationCodeView(phoneNumberInput: .constant(""), action: {
        print("Send verification code tapped")
    })
}

