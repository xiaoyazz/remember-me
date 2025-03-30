//
//  MainTabView.swift
//  remember-me
//
//  Created by Mathew Boyd on 2025-03-29.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }

            
            MemoryGamesView()
                .tabItem {
                    Label("Games", systemImage: "gamecontroller")
                }
            
            DailyPlannerView()
                .tabItem {
                    Label("Planner", systemImage: "plus.circle")
                }

            HealthView()
                .tabItem {
                    Label("Health", systemImage: "heart")
                }

            SOSView()
                .tabItem {
                    Label("SOS", systemImage: "exclamationmark.triangle")
                }
        }
    }
}

#Preview {
    MainTabView()
}
