//
//  CustomButton.swift
//  Chores
//
//  Created by Adrian Witaszak on 28/07/2022.
//

import SwiftUI

struct CustomButton: View {
    
    @State var text: String
    @State var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(text)
                .font(.headline)
                .foregroundColor(.white)
                .frame(width: 360, height: 50)
                .background(.blue.opacity(0.8))
//                .clipShape(Capsule())
                .cornerRadius(10)
        }
    }
}

struct CustomButton_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            BackgroundGradientView()
            CustomButton(text: "Sign in", action: {})
        }
    }
}
