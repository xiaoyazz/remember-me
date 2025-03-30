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

            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.circle")
                }

            MemoryGamesView()
                .tabItem {
                    Label("Games", systemImage: "gamecontroller")
                }

            HealthView()
                .tabItem {
                    Label("Health", systemImage: "heart")
                }

            DailyPlannerView()
                .tabItem {
                    Label("Planner", systemImage: "calendar")
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
