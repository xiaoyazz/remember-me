//
//  MainMemeoryView.swift
//  remember-me
//
//  Created by Mathew Boyd on 2025-03-29.
//

import SwiftUI

struct MainMemeoryView: View {
    @StateObject var metricsLogger = MetricsLogger()
    @State private var showRound1 = false

    var body: some View {
        VStack(spacing: 20) {
            Text("Welcome to Memory Quest!")
                .font(.largeTitle)
                .padding()

            Button(action: {
                showRound1 = true
            }) {
                Text("Start Game")
                    .font(.title2)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        // Wrap Round1View inside a NavigationView (iOS 15 or below) or NavigationStack (iOS 16+)
        .fullScreenCover(isPresented: $showRound1) {
             NavigationStack {
                 Round1View().environmentObject(metricsLogger)
             }
             .navigationBarBackButtonHidden(true)
        }
    }
}

#Preview {
    MainMemeoryView()
}
