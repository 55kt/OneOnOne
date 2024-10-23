//
//  NumField.swift
//  OneOnOne
//
//  Created by Vlad on 22/10/24.
//

import SwiftUI

struct NumField: View {
    // MARK: - Properties
    @Binding var numPlaceholder: String
    var fieldDescription: String
    
    // MARK: - Body
    var body: some View {
        TextField(fieldDescription, text: $numPlaceholder)
            .keyboardType(.phonePad)
            .padding()
            .background(Color(.secondarySystemBackground))
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.gray.opacity(0.4), lineWidth: 1)
            )
            .padding(.horizontal)
    }
}

#Preview {
    NumField(numPlaceholder: .constant(""), fieldDescription: "")
}
