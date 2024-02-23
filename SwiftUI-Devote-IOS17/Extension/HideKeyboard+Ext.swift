//
//  HideKeyboard+Ext.swift
//  SwiftUI-Devote-IOS17
//
//  Created by Daniel Felipe on 20/02/24.
//

import SwiftUI

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
