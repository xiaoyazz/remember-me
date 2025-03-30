//
//  MainTabView.swift
//  remember-me
//
//  Created by Mathew Boyd on 2025-03-30.
//

import SwiftUI

struct CareGiverMainTabView: View {
    var body: some View {
        TabView {
            UserListView()
                .tabItem {
                    Label("Paicents", systemImage: "person.crop.circle")
                }
            //Add Later
//            FollowingListView()
//                .tabItem {
//                    Label("Following", systemImage: "person.3")
//                }
        }
    }
}

#Preview {
    CareGiverMainTabView()
}
