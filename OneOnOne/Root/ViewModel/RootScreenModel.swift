//
//  RootScreenModel.swift
//  OneOnOne
//
//  Created by Vlad on 29/10/24.
//

import SwiftUI
import Combine

final class RootScreenModel: ObservableObject {
    @Published private(set) var authState = AuthState.pending
    private var cancellable: AnyCancellable?
    
    init() {
        print("RootScreenModel: Initializing and observing AuthManager.authState...")
        self.cancellable = AuthManager.shared.authState
            .receive(on: DispatchQueue.main)
            .sink { [weak self] latestAuthState in
                print("RootScreenModel: Received new authState: \(latestAuthState)")
                self?.authState = latestAuthState
            }
    }
}
