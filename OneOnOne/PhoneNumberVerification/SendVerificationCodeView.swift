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
    @State private var selectedCountry: Country = .defaultCountry
    @State var action: () -> ()
    
    // MARK: - Body
    var body: some View {
        VStack(spacing: 20) {
            
            title()
            
            /*
             Поле ввода с выбором страны
             Input field with country selection
             */
            HStack {
                CountryPicker(selectedCountry: $selectedCountry)
                
                phoneInputArea()
            }
            
            /*
             Кнопка подтверждения
             Confirmation button
             */
            VerificationButton(action: { action() }, title: "Send verification code")
            
            Spacer()
        }
        .padding()
        .background(Color(.systemGroupedBackground).ignoresSafeArea())
    }
    
    // MARK: - Methods
    private func title() -> some View {
        Text("Enter your phone number")
            .font(.title2)
            .fontWeight(.bold)
            .foregroundColor(.primary)
            .padding(.top, 40)
    }
    
    private func phoneInputArea() -> some View {
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
}

// MARK: - Preview
#Preview {
    SendVerificationCodeView(phoneNumberInput: .constant(""), action: {
    })
}

