//
//  Round1View.swift
//  remember-me
//
//  Created by Mathew Boyd on 2025-03-29.
//

import SwiftUI

struct Round1View: View {
    @EnvironmentObject var metricsLogger: MetricsLogger
    @EnvironmentObject var statsManager: GameStatsManager
    
    @State private var currentQuestionIndex = 0
    @State private var finished = false
    @State private var questionStartTime = Date()
    @State private var elapsedTime: TimeInterval? = nil
    @State private var roundStartTime = Date()
    @State private var showEnlargedImage = false  // New state to control the enlarged photo
    
    let questions = Questions.round1

    var body: some View {
        VStack {
            // Display the image from assets if available, otherwise show a placeholder.
            if let pictureName = questions[currentQuestionIndex].picture, !pictureName.isEmpty {
                ZStack(alignment: .topTrailing) {
                    Image(pictureName)
                        .resizable()
                        .frame(height: 260)
                        .frame(width: 400)
                        .padding()
                    Button(action: {
                        showEnlargedImage = true
                    }) {
                        Image(systemName: "arrow.up.left.and.arrow.down.right")
                            .padding(8)
                            .background(Color.black.opacity(0.6))
                            .foregroundColor(.white)
                            .clipShape(Circle())
                            .padding(20)
                    }
                }
                .fullScreenCover(isPresented: $showEnlargedImage) {
                    EnlargedPhotoView(imageName: pictureName)
                }
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
            
            // Display elapsed time for the last answered question.
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
                        let elapsed = Date().timeIntervalSince(questionStartTime)
                        elapsedTime = elapsed
                        
                        let isCorrect = index == questions[currentQuestionIndex].answer
                        if isCorrect {
                            metricsLogger.log("Round1 Q\(currentQuestionIndex+1): Correct! Time: \(elapsed) seconds")
                            statsManager.stats.round1Correct += 1
                        } else {
                            metricsLogger.log("Round1 Q\(currentQuestionIndex+1): Incorrect. Selected: \(option) - Time: \(elapsed) seconds")
                        }
                        statsManager.stats.round1ResponseTimes.append(elapsed)
                        
                        if currentQuestionIndex < questions.count - 1 {
                            currentQuestionIndex += 1
                            questionStartTime = Date() // reset timer for next question
                            elapsedTime = nil
                        } else {
                            statsManager.stats.round1TotalTime = Date().timeIntervalSince(roundStartTime)
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
                destination: Round2View().environmentObject(statsManager).environmentObject(metricsLogger),
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
            Round1View()
                .environmentObject(metricsLoggerForPreview())
                .environmentObject(GameStatsManager())
        }
    }
}

// Helper for previews
func metricsLoggerForPreview() -> MetricsLogger {
    let logger = MetricsLogger()
    return logger
}
