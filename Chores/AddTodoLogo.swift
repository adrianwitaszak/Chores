//
//  AddTodoLogo.swift
//  Chores
//
//  Created by Adrian Witaszak on 28/07/2022.
//

import SwiftUI

struct AddTodoLogo: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack {
            Image("login-logo")
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
                .background(colorScheme == .dark ? .clear : Color(.systemBlue))
                .cornerRadius(80)
            
            Text("Add Your First Todo")
                .foregroundColor(colorScheme == .dark ? .white : .black)
                .font(.system(size: 25))
                .fontWeight(.semibold)
        }
        .eraseToAnyView()
    }

    #if DEBUG
    @ObservedObject var iO = injectionObserver
    #endif
}

struct AddTodoLogo_Previews: PreviewProvider {
    static var previews: some View {
        AddTodoLogo()
    }
}
