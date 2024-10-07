//
//  RectKey.swift
//  OneOnOne
//
//  Created by Vlad on 7/10/24.
//

import SwiftUI

struct RectKey: PreferenceKey {
    static var defaultValue: CGRect = .zero
    static func reduce(value: inout CGRect, nextValue: () -> CGRect) {
        value = nextValue()
    }
}
