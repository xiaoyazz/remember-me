//
//  GameStats.swift
//  remember-me
//
//  Created by Mathew Boyd on 2025-03-29.
//

import Foundation

struct GameStats {
    // Correct answer counts for each round.
    var round1Correct: Int = 0
    var round2Correct: Int = 0
    var round3Correct: Int = 0
    
    // Response times for each question in each round (in seconds).
    var round1ResponseTimes: [TimeInterval] = []
    var round2ResponseTimes: [TimeInterval] = []
    var round3ResponseTimes: [TimeInterval] = []
    
    // Total time to complete each round.
    var round1TotalTime: TimeInterval = 0
    var round2TotalTime: TimeInterval = 0
    var round3TotalTime: TimeInterval = 0
    
    //Repeated parts
    var round2AudioReplays: Int = 0
    
    //Age of the user
    var userAge: Int = 0
    

    
    // Computed properties for average response times per round.
    var round1AverageResponseTime: TimeInterval {
        guard !round1ResponseTimes.isEmpty else { return 0 }
        return round1ResponseTimes.reduce(0, +) / Double(round1ResponseTimes.count)
    }
    
    var round2AverageResponseTime: TimeInterval {
        guard !round2ResponseTimes.isEmpty else { return 0 }
        return round2ResponseTimes.reduce(0, +) / Double(round2ResponseTimes.count)
    }
    
    var round3AverageResponseTime: TimeInterval {
        guard !round3ResponseTimes.isEmpty else { return 0 }
        return round3ResponseTimes.reduce(0, +) / Double(round3ResponseTimes.count)
    }

}
