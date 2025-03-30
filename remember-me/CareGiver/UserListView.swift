//
//  UserListView.swift
//  remember-me
//
//  Created by Mathew Boyd on 2025-03-30.
//

//
//  UserListView.swift
//  remember-me
//
//  Created by <Your Name> on <Date>.
//

import SwiftUI

struct UserListView: View {
    @ObservedObject var viewModel: FirebaseUserDirectoryViewModel
    
    @State private var searchText: String = ""
    
    var filteredUsers: [FollowableUser] {
        if searchText.isEmpty {
            return viewModel.users
        } else {
            return viewModel.users.filter { u in
                u.user.name.localizedCaseInsensitiveContains(searchText)
                || u.user.email.localizedCaseInsensitiveContains(searchText)
                || u.user.accountType.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    ForEach(filteredUsers.indices, id: \.self) { index in
                        let item = filteredUsers[index]
                        
                        // Find the real index in the main array
                        if let realIndex = viewModel.users.firstIndex(where: { $0.id == item.id }) {
                            // A custom Binding that sets .isFollowing + updates Firestore
                            let binding = Binding<Bool>(
                                get: { viewModel.users[realIndex].isFollowing },
                                set: { newVal in
                                    // 1) Update local so the UI changes immediately
                                    viewModel.users[realIndex].isFollowing = newVal
                                    // 2) Update Firestore so the change persists
                                    viewModel.toggleFollow(for: item.id)
                                }
                            )
                            
                            UserCardView(
                                user: item.user,
                                isFollowing: binding
                            )
                        }
                    }
                }
                .padding(.top)
            }
            .navigationTitle("User Directory")
            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
        }
    }
}


#Preview {
    let testViewModel = FirebaseUserDirectoryViewModel()
    UserListView(viewModel: testViewModel)
}
