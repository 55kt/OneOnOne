//
//  shareButton.swift
//  OneOnOne
//
//  Created by Vlad on 17/10/24.
//

import SwiftUI

func shareButton() -> some View {
    Button {
        // action
    } label: {
        Image(systemName: "arrowshape.turn.up.right.fill")
            .padding(10)
            .foregroundStyle(.white)
            .background(.shareButton)
            .background(.thinMaterial)
            .clipShape(Circle())
    }
}
