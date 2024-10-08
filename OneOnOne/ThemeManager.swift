//
//  ThemeManager.swift
//  OneOnOne
//
//  Created by Vlad on 8/10/24.
//

import SwiftUI

class ThemeManager: ObservableObject {
    @AppStorage("toggleDarkMode") var toggleDarkMode: Bool = false
    @AppStorage("activateDarkMode") var activateDarkMode: Bool = false
}
