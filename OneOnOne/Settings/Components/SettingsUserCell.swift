//
//  SettingsUserCell.swift
//  OneOnOne
//
//  Created by Vlad on 5/10/24.
//

import SwiftUI

struct SettingsUserCell: View {
    
    // MARK: - Body
    var body: some View {
        Section {
            HStack {
                DefaultUserAvatar(size: 55)
                
                userInfoView()
            }
            SettingsItemCell(cell: .avatar)
        }
    }
    
    // MARK: - Methods
    private func userInfoView() -> some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Text("Test Username")
                    .font(.title2)
                
                Spacer()
                
                Image(.qrCode1)
                    .renderingMode(.template)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30)
                    .padding(5)
                    .foregroundStyle(.blue)
                    .background(Color(.systemGray2))
                    .clipShape(Circle())
            }
            
            Text("Hello, World! This is ono")
                .foregroundStyle(.gray)
                .font(.callout)
        }
        .lineLimit(1)
    }
}

// MARK: - Preview
#Preview {
    SettingsUserCell()
}
