//
//  SplashView.swift
//  remember-me
//
//  Created by Xiaoya Zou on 2025-03-29.
//

import SwiftUI

struct SplashView: View {
    @State private var isActive = false
    @Binding var isLoggedIn: Bool

    var body: some View {
        if isActive {
            LoginView(isLoggedIn: $isLoggedIn)
        } else {
            VStack {
                Image("rm")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 300)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.white)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    withAnimation {
                        isActive = true
                    }
                }
            }
        }
    }
}


#Preview {
    SplashView(isLoggedIn: .constant(false))
}
