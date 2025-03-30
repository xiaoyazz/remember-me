//
//  UserListView.swift
//  remember-me
//
//  Created by Mathew Boyd on 2025-03-30.
//

import SwiftUI

struct UserListView: View {
    @State private var users: [FollowableUser] = [
        FollowableUser(user: User(name: "Mathew Boyd", age: "22", email: "mathew@example.com", accountType: "Patient"), isFollowing: true),
        FollowableUser(user: User(name: "Dr. Emily Chen", age: "35", email: "emily.chen@clinic.com", accountType: "Clinician"), isFollowing: false),
        FollowableUser(user: User(name: "Alex Johnson", age: "42", email: "alex.johnson@example.com", accountType: "Patient"), isFollowing: false),
        FollowableUser(user: User(name: "Sarah Patel", age: "30", email: "sarah.patel@example.com", accountType: "Clinician"), isFollowing: true),
        FollowableUser(user: User(name: "Olivia Kim", age: "24", email: "olivia.kim@example.com", accountType: "Patient"), isFollowing: false)
    ]
    
    @State private var searchText: String = ""
    
    var filteredUsers: [FollowableUser] {
        if searchText.isEmpty {
            return users
        } else {
            return users.filter { user in
                user.user.name.localizedCaseInsensitiveContains(searchText) ||
                user.user.email.localizedCaseInsensitiveContains(searchText) ||
                user.user.accountType.localizedCaseInsensitiveContains(searchText)
            }
        }
    }

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    ForEach(filteredUsers.indices, id: \.self) { index in
                        UserCardView(
                            user: filteredUsers[index].user,
                            isFollowing: binding(for: filteredUsers[index].id)
                        )
                    }
                }
                .padding(.top)
            }
            .navigationTitle("User Directory")
            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
        }
    }

    // Helper: Get the binding to isFollowing for a user by ID
    private func binding(for id: UUID) -> Binding<Bool> {
        guard let index = users.firstIndex(where: { $0.id == id }) else {
            return .constant(false) // fallback
        }
        return $users[index].isFollowing
    }
}


#Preview {
    UserListView()
}
