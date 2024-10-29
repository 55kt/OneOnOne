//
//  RootScreen.swift
//  OneOnOne
//
//  Created by Vlad on 29/10/24.
//

import SwiftUI

struct RootScreen: View {
    @StateObject var viewModel = RootScreenModel()
    
    var body: some View {
        switch viewModel.authState {
        case .pending:
            ProgressView()
                .controlSize(.large)
            
        case .loggedIn(let loggedInUser):
            MainTabView()
        case .loggedOut:
            SendVerificationCodeView()
        }
    }
}

#Preview {
    RootScreen()
}
