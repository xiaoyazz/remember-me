//
//  UserStruct.swift
//  remember-me
//
//  Created by Mathew Boyd on 2025-03-30.
//

import Foundation

struct User: Identifiable {
    let id = UUID()
    let name: String
    let age: Int
    let email: String
    let accountType: String
}

struct FollowableUser: Identifiable {
    let id: String          
    var user: User
    var isFollowing: Bool
}

