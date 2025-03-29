//
//  HomeView.swift
//  remember-me
//
//  Created by Xiaoya Zou on 2025-03-29.
//

import SwiftUI

struct HomeView: View {
    
    // test by xiaoya
    
    var body: some View {
        TabView {
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
    HomeView()
}
