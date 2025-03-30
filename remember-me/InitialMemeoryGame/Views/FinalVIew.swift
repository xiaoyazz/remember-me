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

    @StateObject private var modelManager = AlzheimersModelManager()
    @State private var predictedDiagnosis: String? = nil
    @State private var goHome = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 15) {
                Text("Thank you for playing Memory Quest!")
                    .font(.largeTitle)
                    .padding(.bottom, 10)

                Text("Game Summary")
                    .font(.title2)
                    .bold()

                Group {
                    Text("Round 1:")
                    Text(" - Correct: \(statsManager.stats.round1Correct) out of \(Questions.round1.count)")
                    Text(String(format: " - Average Response Time: %.2f seconds", statsManager.stats.round1AverageResponseTime))
                    Text(String(format: " - Total Time: %.2f seconds", statsManager.stats.round1TotalTime))
                }

                Divider()

                Group {
                    Text("Round 2:")
                    Text(" - Correct: \(statsManager.stats.round2Correct) out of \(Questions.round2.count)")
                    Text(" - Replay Audio Used: \(statsManager.stats.round2AudioReplays)")
                    Text(String(format: " - Average Response Time: %.2f seconds", statsManager.stats.round2AverageResponseTime))
                    Text(String(format: " - Total Time: %.2f seconds", statsManager.stats.round2TotalTime))
                }

                Divider()

                Group {
                    Text("Round 3:")
                    Text(" - Correct: \(statsManager.stats.round3Correct) out of \(Questions.round3.count)")
                    Text(String(format: " - Average Response Time: %.2f seconds", statsManager.stats.round3AverageResponseTime))
                    Text(String(format: " - Total Time: %.2f seconds", statsManager.stats.round3TotalTime))
                }

                Divider()

                Text("All answers were logged and your performance has been recorded.")
                    .padding(.top)
                    .bold()

                if let diagnosis = predictedDiagnosis {
                    Text("Predicted Diagnosis: \(diagnosis.capitalized)")
                        .font(.title2)
                        .foregroundColor(.blue)
                        .padding(.top)
                } else {
                    Text("Predicting diagnosis...")
                        .foregroundColor(.gray)
                        .padding(.top)
                }

                Divider()

                Text("Your Answer Summary")
                    .font(.title2)
                    .bold()
                    .padding(.top)

                if metricsLogger.logs.isEmpty {
                    Text("No logs recorded.")
                        .foregroundColor(.gray)
                        .padding(.top, 4)
                } else {
                    ForEach(metricsLogger.logs.indices, id: \.self) { index in
                        Text("\(metricsLogger.logs[index])")
                            .padding(.vertical, 2)
                    }
                }

                Spacer()

                Button(action: {
                    goHome = true
                }) {
                    Text("Take Me Home")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(.top, 30)
                }
            }
            .padding()
        }
        .navigationBarBackButtonHidden(true)
        .onAppear {
            let vectorForModel = statsManager.featureVector()
            let orderedVector = statsManager.featureVectorArray()

            print("Feature Vector (dict for model): \(vectorForModel)")
            print("Ordered Feature Vector (array for debug): \(orderedVector)")

            predictedDiagnosis = modelManager.predictDiagnosis(featureDict: vectorForModel)
        }
        .fullScreenCover(isPresented: $goHome) {
            MainTabView()
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
