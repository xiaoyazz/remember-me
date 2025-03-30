//
//  GameStatsManager.swift
//  remember-me
//
//  Created by Mathew Boyd on 2025-03-29.
//

import Foundation
import SwiftUI

class GameStatsManager: ObservableObject {
    @Published var stats = GameStats()
    
    func featureVectorArray() -> [Double] {
        return [
            Double(stats.userAge),                         
            Double(stats.round1Correct),
            Double(stats.round2Correct),
            Double(stats.round3Correct),
            stats.round1AverageResponseTime,
            stats.round2AverageResponseTime,
            stats.round3AverageResponseTime,
            stats.round1TotalTime,
            stats.round2TotalTime,
            stats.round3TotalTime,
            Double(stats.round2AudioReplays),
            Double(stats.round1Correct + stats.round2Correct + stats.round3Correct),
            stats.round1TotalTime + stats.round2TotalTime + stats.round3TotalTime
        ]
    }

    
    func featureVector() -> [String: Double] {
        return [
            "age": Double(stats.userAge),
            "round1Correct": Double(stats.round1Correct),
            "round2Correct": Double(stats.round2Correct),
            "round3Correct": Double(stats.round3Correct),
            "round1AverageResponseTime": stats.round1AverageResponseTime,
            "round2AverageResponseTime": stats.round2AverageResponseTime,
            "round3AverageResponseTime": stats.round3AverageResponseTime,
            "round1TotalTime": stats.round1TotalTime,
            "round2TotalTime": stats.round2TotalTime,
            "round3TotalTime": stats.round3TotalTime,
            "round2AudioReplays": Double(stats.round2AudioReplays),
            "totalCorrect": Double(stats.round1Correct + stats.round2Correct + stats.round3Correct),
            "overallTotalTime": stats.round1TotalTime + stats.round2TotalTime + stats.round3TotalTime
        ]
    }


}
