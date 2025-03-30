//
//  MainTabView.swift
//  remember-me
//
//  Created by Mathew Boyd on 2025-03-30.
//

import SwiftUI

struct CareGiverMainTabView: View {
    @StateObject private var viewModel = FirebaseUserDirectoryViewModel()
    
    var body: some View {
        TabView {
            UserListView(viewModel: viewModel)
                .tabItem {
                    Label("Patients", systemImage: "person.crop.circle")
                }

            FollowingUserListView(viewModel: viewModel)
                .tabItem {
                    Label("Following", systemImage: "person.3")
                }
        }
    }
}

#Preview {
    CareGiverMainTabView()
}
