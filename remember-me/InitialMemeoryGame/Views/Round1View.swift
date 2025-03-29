//
//  Round1View.swift
//  remember-me
//
//  Created by Mathew Boyd on 2025-03-29.
//

import SwiftUI

struct Round1View: View {
    @EnvironmentObject var metricsLogger: MetricsLogger
    @State private var currentQuestionIndex = 0
    @State private var finished = false
    @State private var questionStartTime = Date()  // Start time for the current question
    @State private var elapsedTime: TimeInterval? = nil  // Elapsed time for the answered question
    
    let questions = Questions.round1

    var body: some View {
        VStack {

            if let pictureName = questions[currentQuestionIndex].picture, !pictureName.isEmpty {
                Image(pictureName)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 200)
                    .clipped()
                    .padding()
            } else {
                Rectangle()
                    .fill(Color.green.opacity(0.3))
                    .frame(height: 200)
                    .overlay(Text("Image Placeholder").foregroundColor(.black))
                    .padding()
            }
            
            
            Text(questions[currentQuestionIndex].text)
                .font(.title2)
                .padding()
            
            // Display the elapsed time for the last answered question if available.
            if let elapsed = elapsedTime {
                Text(String(format: "Time to answer: %.2f seconds", elapsed))
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .padding(.bottom)
            }
            
            VStack {
                ForEach(questions[currentQuestionIndex].options.indices, id: \.self) { index in
                    let option = questions[currentQuestionIndex].options[index]
                    Button(action: {
                        // Calculate how long the user took for this question.
                        let elapsed = Date().timeIntervalSince(questionStartTime)
                        elapsedTime = elapsed
                        let isCorrect = index == questions[currentQuestionIndex].answer
                        if isCorrect {
                            metricsLogger.log("Round1 Q\(currentQuestionIndex+1): Correct! Time: \(elapsed) seconds")
                        } else {
                            metricsLogger.log("Round1 Q\(currentQuestionIndex+1): Incorrect. Selected: \(option) - Time: \(elapsed) seconds")
                        }
                        // Move to the next question or finish the round.
                        if currentQuestionIndex < questions.count - 1 {
                            currentQuestionIndex += 1
                            // Reset the timer for the next question.
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
            }
            
            NavigationLink(
                destination: Round2View().environmentObject(metricsLogger),
                isActive: $finished
            ) {
                EmptyView()
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .principal) {
                CustomTitleView(title: "Round 1: Attention & Visual Search")
            }
        }
    }
}

struct Round1View_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            Round1View().environmentObject(MetricsLogger())
        }
    }
}
