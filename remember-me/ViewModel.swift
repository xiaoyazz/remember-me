//
//  FirebaseUserDirectoryViewModel.swift
//  remember-me
//
//  Created by <Your Name> on <Date>.
//

import SwiftUI
import Firebase
import FirebaseFirestore

class FirebaseUserDirectoryViewModel: ObservableObject {
    @Published var users: [FollowableUser] = []
    
    init() {
        fetchUsers()
    }
    
    private func fetchUsers() {
        let db = Firestore.firestore()
        
        // If you want real-time updates, use addSnapshotListener:
        db.collection("users").addSnapshotListener { snapshot, error in
        // If you only want a one-time fetch, use getDocuments:
        // db.collection("users").getDocuments { snapshot, error in
            
            if let error = error {
                print("Error fetching documents: \(error.localizedDescription)")
                return
            }
            guard let documents = snapshot?.documents else { return }

            // Parse each document into FollowableUser
            self.users = documents.compactMap { doc in
                let data = doc.data()
                
                // Grab fields you expect
                guard let name = data["name"] as? String,
                      let age = data["age"] as? String,
                      let email = data["email"] as? String,
                      let accountType = data["accountType"] as? String
                else {
                    // If missing any field, skip this doc
                    return nil
                }
                
                // If your DB also stores a boolean `isFollowing`
                let isFollowing = data["isFollowing"] as? Bool ?? false
                
                // Make the base User
                let user = User(name: name,
                                age: age,
                                email: email,
                                accountType: accountType)
                
                // The Firestore doc ID is doc.documentID
                return FollowableUser(
                    id: doc.documentID,   // <-- important fix
                    user: user,
                    isFollowing: isFollowing
                )
            }
        }
    }
    
    /// Toggle local isFollowing AND persist changes in Firestore
    func toggleFollow(for docId: String) {
        // Find the index in local array
        guard let index = users.firstIndex(where: { $0.id == docId }) else { return }
        
        // Flip local state
        users[index].isFollowing.toggle()
        let newValue = users[index].isFollowing
        
        // Push update to Firestore
        let db = Firestore.firestore()
        db.collection("users").document(docId).updateData(["isFollowing": newValue]) { error in
            if let error = error {
                print("Error updating isFollowing: \(error.localizedDescription)")
            } else {
                print("Successfully updated isFollowing in Firestore for doc: \(docId)")
            }
        }
    }
}
