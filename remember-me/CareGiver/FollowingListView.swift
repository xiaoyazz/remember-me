//
//  FollowingListView.swift
//  remember-me
//
//  Created by Mathew Boyd on 2025-03-30.
//

import SwiftUI

struct FollowingUserListView: View {
    @ObservedObject var viewModel: FirebaseUserDirectoryViewModel
    
    var followedUsers: [FollowableUser] {
        viewModel.users.filter { $0.isFollowing }
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                if followedUsers.isEmpty {
                    Text("Not following anyone yet.")
                        .foregroundColor(.gray)
                        .padding()
                } else {
                    ForEach(followedUsers.indices, id: \.self) { index in
                        let item = followedUsers[index]
                        
                        if let realIndex = viewModel.users.firstIndex(where: { $0.id == item.id }) {
                            let binding = Binding<Bool>(
                                get: { viewModel.users[realIndex].isFollowing },
                                set: { newVal in
                                    viewModel.users[realIndex].isFollowing = newVal
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
            }
            .padding(.top)
        }
        .navigationTitle("Following")
    }
}

#Preview {
    let testViewModel = FirebaseUserDirectoryViewModel()
    
    // Optionally, you can add some mock data here if you want immediate preview
    // e.g. testViewModel.users = [FollowableUser(...), FollowableUser(...)]

    return FollowingUserListView(viewModel: testViewModel)
}
