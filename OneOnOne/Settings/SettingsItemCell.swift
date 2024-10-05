//
//  SettingsItemCell.swift
//  OneOnOne
//
//  Created by Vlad on 5/10/24.
//

import SwiftUI

struct SettingsItemCell: View {
    // MARK: - Properties
    let cell: SettingsCell
    
    // MARK: - Body
    var body: some View {
        HStack {
            iconImageView()
                
            Text(cell.title)
                .font(.system(size: 18))
            
            Spacer()
        }
    }
    
    /*
     Иконка ячейки настроек
     Settings cell icon
     */
    @ViewBuilder
    private func iconImageView() -> some View {
        Image(systemName: cell.imageName)
            .frame(width: 30, height: 30)
            .foregroundStyle(.white)
            .background(cell.backgroundColor)
            .clipShape(RoundedRectangle(cornerRadius: 5, style: .continuous))
    }
}

// MARK: - Preview
#Preview {
    SettingsItemCell(cell: .saveToCameraRoll)
}
