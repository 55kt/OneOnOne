//
//  RootScreen.swift
//  OneOnOne
//
//  Created by Vlad on 29/10/24.
//

import SwiftUI

struct RootScreen: View {
    // MARK: - Properties
    @StateObject var viewModel = RootScreenModel()
    @EnvironmentObject var authModel: AuthScreenModel  // Подключаем AuthScreenModel
    
    // MARK: - Body
    var body: some View {
        switch viewModel.authState {
        case .pending:
            ProgressView()
                .controlSize(.large)
                .onAppear {
                    print("RootScreen displaying: ProgressView")
                }
            
        case .loggedIn(let loggedInUser):
            MainTabView(loggedInUser) 
                .onAppear {
                    print("RootScreen displaying: MainTabView with loggedInUser")
                }
            
        case .loggedOut:
            if authModel.isVerificationSent {
                ConfirmVerifyCodeView()
                    .onAppear {
                        print("RootScreen displaying: ConfirmVerifyCodeView")
                    }
            } else {
                SendVerificationCodeView()
                    .onAppear {
                        print("RootScreen displaying: SendVerificationCodeView")
                    }
            }
        }
    }
}

// MARK: - Preview
#Preview {
    RootScreen().environmentObject(AuthScreenModel())
}
