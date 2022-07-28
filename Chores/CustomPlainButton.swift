//
//  CustomPlainButton.swift
//  Chores
//
//  Created by Adrian Witaszak on 28/07/2022.
//

import SwiftUI

struct CustomPlainButton: View {
    
    @State var text: String
    @State var action: () -> Void
    @State var fontSize: CGFloat = 13.0
    @State var fontWeight: Font.Weight = .semibold
    @State var foregroundColor: Color = .white
    
    var body: some View {
        Button(action: action) {
            Text(text)
                .font(.system(size: fontSize, weight: fontWeight))
                .foregroundColor(foregroundColor)
        }
        .eraseToAnyView()
    }

    #if DEBUG
    @ObservedObject var iO = injectionObserver
    #endif
}

struct CustomPlainButton_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            BackgroundGradientView()
            CustomPlainButton(text: "Forgot password", action: {})
        }
    }
}
