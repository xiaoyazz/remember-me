//
//  PlannerTask.swift
//  remember-me
//
//  Created by Xiaoya Zou on 2025-03-29.
//

import Foundation

struct PlannerTask: Identifiable, Codable {
    let id: String 
    let date: String 
    let time: String
    let description: String
    let note: String?
    let category: String?
}
