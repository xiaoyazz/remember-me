//
//  MainMemeoryView.swift
//  remember-me
//
//  Created by Mathew Boyd on 2025-03-29.
//

import SwiftUI

struct MainMemeoryView: View {
    @StateObject var metricsLogger = MetricsLogger()
    @StateObject var statsManager = GameStatsManager()  
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
        .fullScreenCover(isPresented: $showRound1) {
            NavigationStack {
                Round1View()
                    .environmentObject(metricsLogger)
                    .environmentObject(statsManager)
            }
            .navigationBarBackButtonHidden(true)
        }
    }
}

struct MainMemeoryView_Previews: PreviewProvider {
    static var previews: some View {
        MainMemeoryView()
    }
}
