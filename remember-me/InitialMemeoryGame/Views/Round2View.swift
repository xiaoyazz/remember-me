//
//  Round2View.swift
//  remember-me
//
//  Created by Mathew Boyd on 2025-03-29.
//
import SwiftUI
import AVFoundation

struct Round2View: View {
    @EnvironmentObject var metricsLogger: MetricsLogger
    @EnvironmentObject var statsManager: GameStatsManager

    @State private var currentQuestionIndex = 0
    @State private var finished = false
    @State private var questionStartTime = Date()
    @State private var elapsedTime: TimeInterval? = nil
    @State private var roundStartTime = Date()
    @State private var audioFinished = true  

    let questions = Questions.round2

    private let synthesizer = AVSpeechSynthesizer()
    private let audioDelegate = AudioDelegate()

    // Function to speak the current question.
    private func speakQuestion() {
        let utterance = AVSpeechUtterance(string: questions[currentQuestionIndex].text)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        audioFinished = false  // Hide answer options until speech finishes.
        synthesizer.speak(utterance)
    }

    var body: some View {
        VStack {
            // If the question should be spoken, center the audio UI.
            if questions[currentQuestionIndex].shouldBeSpoken {
                VStack {
                    Spacer()
                    Button("Replay Audio") {
                        speakQuestion()
                        // (Optional) Update any replay counter here.
                    }
                    .padding()
                    .background(Color.orange.opacity(0.8))
                    .foregroundColor(.white)
                    .cornerRadius(8)
                    .frame(maxWidth: .infinity)
                    Spacer()
                }
                .onAppear {
                    synthesizer.delegate = audioDelegate
                    audioDelegate.onFinish = {
                        DispatchQueue.main.async {
                            self.audioFinished = true
                        }
                    }
                    speakQuestion()
                }
            } else {
                // Otherwise, display the question text normally.
                Text(questions[currentQuestionIndex].text)
                    .font(.title2)
                    .padding()
            }
            
            if let elapsed = elapsedTime {
                Text(String(format: "Time to answer: %.2f seconds", elapsed))
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .padding(.bottom)
            }
            
            // Only show answer options if either the question is not spoken
            // or the audio has finished.
            if !questions[currentQuestionIndex].shouldBeSpoken || audioFinished {
                ForEach(questions[currentQuestionIndex].options.indices, id: \.self) { index in
                    let option = questions[currentQuestionIndex].options[index]
                    Button(action: {
                        // Immediately stop any audio.
                        synthesizer.stopSpeaking(at: .immediate)
                        
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
            Round2View()
                .environmentObject(metricsLoggerForPreview())
                .environmentObject(GameStatsManager())
        }
    }
}
