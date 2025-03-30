//
//  FamilyMember.swift
//  remember-me
//
//  Created by Xiaoya Zou on 2025-03-29.
//

import Foundation

struct FamilyMember: Identifiable, Codable {
    let id: String
    let name: String
    let relationship: String
    let description: String?
    let imageName: String // Name of image in asset catalog or file system
}
