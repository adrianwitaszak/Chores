//
//  View+Modifiers.swift
//  Chores
//
//  Created by Adrian Witaszak on 28/07/2022.
//

import SwiftUI

extension View {
    func searchTextFieldModifier() -> some View {
        modifier(SearchTextFieldModifier())
    }
}

struct SearchTextFieldModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 17))
            .padding(.leading, 24)
            .padding(.horizontal)
            .frame(height: 45)
            .background(Color(.systemGray6))
            .cornerRadius(15)
        .eraseToAnyView()
    }

    #if DEBUG
    @ObservedObject var iO = injectionObserver
    #endif
}
