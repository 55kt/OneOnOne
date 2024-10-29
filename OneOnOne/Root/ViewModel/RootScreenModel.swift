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
        cancellable = AuthManager.shared.authState.receive(on: DispatchQueue.main)
            .sink {[weak self] latestAuthState in
                self?.authState = latestAuthState
            }
    }
}
