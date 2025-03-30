//
//  FinalView.swift
//  remember-me
//
//  Created by Mathew Boyd on 2025-03-29.
//

import SwiftUI

struct FinalView: View {
    @EnvironmentObject var statsManager: GameStatsManager
    @EnvironmentObject var metricsLogger: MetricsLogger
    
    var body: some View {
        VStack {
            Text("Thank you for playing Memory Quest!")
                .font(.largeTitle)

            
            
            VStack(alignment: .leading, spacing: 15) {
                Text("Game Summary")
                    .font(.largeTitle)

                
                Group {
                    Text("Round 1:")
                    Text(" - Correct: \(statsManager.stats.round1Correct) out of \(Questions.round1.count)")
                    Text(String(format: " - Average Response Time: %.2f seconds", statsManager.stats.round1AverageResponseTime))
                    Text(String(format: " - Total Time: %.2f seconds", statsManager.stats.round1TotalTime))
                }
                
                Group {
                    Text("Round 2:")
                    Text(" - Correct: \(statsManager.stats.round2Correct) out of \(Questions.round2.count)")
                    Text (" - Replay Audio to hear correct answers: \(statsManager.stats.round2AudioReplays)")
                    Text(String(format: " - Average Response Time: %.2f seconds", statsManager.stats.round2AverageResponseTime))
                    Text(String(format: " - Total Time: %.2f seconds", statsManager.stats.round2TotalTime))
                }
                
                Group {
                    Text("Round 3:")
                    Text(" - Correct: \(statsManager.stats.round3Correct) out of \(Questions.round3.count)")
                    Text(String(format: " - Average Response Time: %.2f seconds", statsManager.stats.round3AverageResponseTime))
                    Text(String(format: " - Total Time: %.2f seconds", statsManager.stats.round3TotalTime))
                }
                //Add if statment if they actually have been recored or not (Later on)
                Text("Your performance metrics have been recorded.")
                    .padding()
                    .bold(true)
                
                Spacer()
            }
            .padding()
        }
        .onAppear {
            let featureVector = statsManager.featureVector()
            print("Feature Vector: \(featureVector)")
        }
    }
}

struct FinalView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            FinalView()
                .environmentObject(GameStatsManager())
                .environmentObject(metricsLoggerForPreview())
        }
    }
}
