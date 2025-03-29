//
//  Round2View.swift
//  remember-me
//
//  Created by Mathew Boyd on 2025-03-29.
//
import SwiftUI

struct Round2View: View {
    @EnvironmentObject var metricsLogger: MetricsLogger
    @State private var currentQuestionIndex = 0
    @State private var finished = false
    @State private var questionStartTime = Date()
    @State private var elapsedTime: TimeInterval? = nil
    
    // Use round2 questions from the Questions struct.
    let questions = Questions.round2

    var body: some View {
        VStack {
            Text(questions[currentQuestionIndex].text)
                .padding()
                .font(.title2)
            
            // Display elapsed time if available.
            if let elapsed = elapsedTime {
                Text(String(format: "Time to answer: %.2f seconds", elapsed))
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .padding(.bottom)
            }
            
            ForEach(questions[currentQuestionIndex].options.indices, id: \.self) { index in
                let option = questions[currentQuestionIndex].options[index]
                Button(action: {
                    // Calculate elapsed time since the question was shown.
                    let elapsed = Date().timeIntervalSince(questionStartTime)
                    elapsedTime = elapsed
                    
                    let isCorrect = index == questions[currentQuestionIndex].answer
                    if isCorrect {
                        metricsLogger.log("Round2 Q\(currentQuestionIndex+1): Correct! Time: \(elapsed) seconds")
                    } else {
                        metricsLogger.log("Round2 Q\(currentQuestionIndex+1): Incorrect. Selected: \(option) - Time: \(elapsed) seconds")
                    }
                    
                    // Move to the next question or finish the round.
                    if currentQuestionIndex < questions.count - 1 {
                        currentQuestionIndex += 1
                        // Reset timer for the next question.
                        questionStartTime = Date()
                        elapsedTime = nil
                    } else {
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
                destination: Round3View().environmentObject(metricsLogger),
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
            Round2View().environmentObject(MetricsLogger())
        }
    }
}
