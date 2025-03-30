//
//  FollowingListView.swift
//  remember-me
//
//  Created by Mathew Boyd on 2025-03-30.
//

import SwiftUI

struct FollowingListView: View {
    @Binding var users: [FollowableUser]

    // Filter followed users
    var followedUsers: [FollowableUser] {
        users.filter { $0.isFollowing }
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                if followedUsers.isEmpty {
                    Text("You're not following anyone yet.")
                        .font(.title3)
                        .foregroundColor(.gray)
                        .padding()
                } else {
                    ForEach(followedUsers.indices, id: \.self) { index in
                        let followedUser = followedUsers[index]
                        UserCardView(
                            user: followedUser.user,
                            isFollowing: binding(for: followedUser.id)
                        )
                    }
                }
            }
            .padding(.top)
        }
        .navigationTitle("Following")
    }

    // Provide binding to the user's follow state
    private func binding(for id: UUID) -> Binding<Bool> {
        guard let index = users.firstIndex(where: { $0.id == id }) else {
            return .constant(false)
        }
        return $users[index].isFollowing
    }
}

#Preview {
    StatefulPreviewWrapper([
        FollowableUser(user: User(name: "Test User", age: "30", email: "test@example.com", accountType: "Patient"), isFollowing: true),
        FollowableUser(user: User(name: "Not Followed", age: "40", email: "nope@example.com", accountType: "Patient"), isFollowing: false)
    ]) { users in
        FollowingListView(users: users)
    }
}
