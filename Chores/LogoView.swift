//
//  LogoView.swift
//  Chores
//
//  Created by Adrian Witaszak on 28/07/2022.
//

import SwiftUI

struct LogoView: View {
    var body: some View {
        VStack {
            Image("login-logo")
                .resizable()
                .scaledToFit()
            .frame(width: 150, height: 150)
            
            Text("All Done")
                .foregroundColor(.white)
                .fontWeight(.semibold)
        }
        .eraseToAnyView()
    }

    #if DEBUG
    @ObservedObject var iO = injectionObserver
    #endif
}

struct LogoView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            BackgroundGradientView()
            LogoView()
        }
    }
}
