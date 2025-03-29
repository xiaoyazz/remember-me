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
    
    func featureVector() -> [String: Double] {
            var features = [String: Double]()
            
            features["round1Correct"] = Double(stats.round1Correct)
            features["round2Correct"] = Double(stats.round2Correct)
            features["round3Correct"] = Double(stats.round3Correct)
            
            features["round1AverageResponseTime"] = stats.round1AverageResponseTime
            features["round2AverageResponseTime"] = stats.round2AverageResponseTime
            features["round3AverageResponseTime"] = stats.round3AverageResponseTime
            
            features["round1TotalTime"] = stats.round1TotalTime
            features["round2TotalTime"] = stats.round2TotalTime
            features["round3TotalTime"] = stats.round3TotalTime
            

            let totalCorrect = stats.round1Correct + stats.round2Correct + stats.round3Correct
            features["totalCorrect"] = Double(totalCorrect)
            
            let overallTotalTime = stats.round1TotalTime + stats.round2TotalTime + stats.round3TotalTime
            features["overallTotalTime"] = overallTotalTime
            
            return features
        }
}
