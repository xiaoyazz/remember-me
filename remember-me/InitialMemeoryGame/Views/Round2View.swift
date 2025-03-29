//
//  Round2View.swift
//  remember-me
//
//  Created by Mathew Boyd on 2025-03-29.
//
import SwiftUI

struct Round2View: View {
    @EnvironmentObject var metricsLogger: MetricsLogger
    @EnvironmentObject var statsManager: GameStatsManager
    
    @State private var currentQuestionIndex = 0
    @State private var finished = false
    @State private var questionStartTime = Date()
    @State private var elapsedTime: TimeInterval? = nil
    @State private var roundStartTime = Date()
    
    let questions = Questions.round2

    var body: some View {
        VStack {
            Text(questions[currentQuestionIndex].text)
                .font(.title2)
                .padding()
            
            if let elapsed = elapsedTime {
                Text(String(format: "Time to answer: %.2f seconds", elapsed))
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .padding(.bottom)
            }
            
            ForEach(questions[currentQuestionIndex].options.indices, id: \.self) { index in
                let option = questions[currentQuestionIndex].options[index]
                Button(action: {
                    let elapsed = Date().timeIntervalSince(questionStartTime)
                    elapsedTime = elapsed
                    
                    let isCorrect = index == questions[currentQuestionIndex].answer
                    if isCorrect {
                        metricsLogger.log("Round2 Q\(currentQuestionIndex+1): Correct! Time: \(elapsed) seconds")
                        statsManager.stats.round2Correct += 1
                    } else {
                        metricsLogger.log("Round2 Q\(currentQuestionIndex+1): Incorrect. Selected: \(option) - Time: \(elapsed) seconds")
                    }
                    statsManager.stats.round2ResponseTimes.append(elapsed)
                    
                    if currentQuestionIndex < questions.count - 1 {
                        currentQuestionIndex += 1
                        questionStartTime = Date()
                        elapsedTime = nil
                    } else {
                        statsManager.stats.round2TotalTime = Date().timeIntervalSince(roundStartTime)
                        finished = true
                    }
                }) {
                    Text(option)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue.opacity(0.7))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(.horizontal)
                }
            }
            
            NavigationLink(
                destination: Round3View().environmentObject(statsManager).environmentObject(metricsLogger),
                isActive: $finished
            ) {
                EmptyView()
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .principal) {
                CustomTitleView(title: "Round 2: Cognitive Ability")
            }
        }
    }
}

struct Round2View_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            Round2View().environmentObject(metricsLoggerForPreview()).environmentObject(GameStatsManager())
        }
    }
}
