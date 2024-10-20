//
//  InitialView.swift
//  OneOnOne
//
//  Created by Vlad on 20/10/24.
//

import SwiftUI
import FirebaseAuth

struct InitialView: View {
    
    @State private var userLoggedIn = (Auth.auth().currentUser != nil)
    
    
    var body: some View {
        VStack{
            if userLoggedIn{
                MainTabView()
            } else {
                EmptyView()
            }
            
            
        }.onAppear{
            
            Auth.auth().addStateDidChangeListener{auth, user in
            
                if (user != nil) {
                    
                    userLoggedIn = true
                } else{
                    userLoggedIn = false
                }
            }
        }
    }
}

#Preview {
    InitialView()
}
