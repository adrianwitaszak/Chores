//
//  CustomTextField.swift
//  Chores
//
//  Created by Adrian Witaszak on 28/07/2022.
//

import SwiftUI

struct CustomTextField: View {
    
    @Binding var value: String
    @State var imageName: String = ""
    @State var placeholder: String = ""
    var foregroundColor: Color = .white
    var isSecure: Bool = false
    
    var body: some View {
        ZStack(alignment: .leading) {
            if value.isEmpty {
                Text(placeholder)
                    .foregroundColor(foregroundColor.opacity(0.8))
                    .padding(.leading, 40)
                
            }
            
            HStack {
                if !imageName.isEmpty {
                    Image(systemName: imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                        .foregroundColor(foregroundColor)
                }
                
                if !isSecure {
                    TextField("", text: $value)
                        .autocapitalization(.none)
                } else {
                    SecureField("", text: $value)
                        .autocapitalization(.none)
                }
            }
        }
        .padding()
        .background(.white.opacity(0.15))
        .cornerRadius(10)
        .foregroundColor(.white)
        .eraseToAnyView()
    }

    #if DEBUG
    @ObservedObject var iO = injectionObserver
    #endif
}

struct EmailTextField_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            BackgroundGradientView()
            VStack {
                CustomTextField(value: .constant("Email"), isSecure: false)
                CustomTextField(value: .constant("Email"), isSecure: true)
            }.padding()
        }
    }
}
