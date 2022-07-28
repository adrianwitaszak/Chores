//
//  TodoTextfield.swift
//  Chores
//
//  Created by Adrian Witaszak on 28/07/2022.
//

import SwiftUI

struct TodoTextField: View {
    
    @Binding var text: String
    let placeholder: String
    
    var body: some View {
        CustomTextField(
            value: $text,
            imageName: "checkmark.square",
            placeholder: placeholder,
            foregroundColor: .gray
        )
        .background(Color(.systemGray6))
        .cornerRadius(10)
        .eraseToAnyView()
    }

    #if DEBUG
    @ObservedObject var iO = injectionObserver
    #endif
}

struct TodoTextField_Previews: PreviewProvider {
    static var previews: some View {
        TodoTextField(text: .constant(""), placeholder: "Title")
    }
}
