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
        audioFinished = false
        synthesizer.speak(utterance)
    }

    var body: some View {
        VStack {
            Group {
                if questions[currentQuestionIndex].shouldBeSpoken {
                    // Center the audio UI with fade transition.
                    VStack {
                        Spacer()
                        Button("Replay Audio") {
                            synthesizer.stopSpeaking(at: .immediate)
                            synthesizer.delegate = audioDelegate
                            audioDelegate.onFinish = {
                                DispatchQueue.main.async {
                                    withAnimation(.easeInOut) {
                                        self.audioFinished = true
                                    }
                                }
                            }
                            speakQuestion()
                            statsManager.stats.round2AudioReplays += 1
                        }
                        .padding()
                        // Change the background based on audioFinished state.
                        .background(audioFinished ? Color.orange.opacity(0.8) : Color.gray.opacity(0.5))
                        .foregroundColor(.white)
                        .cornerRadius(8)
                        .disabled(!audioFinished)
                        Spacer()
                    }
                    .transition(.opacity)
                    .onAppear {
                        synthesizer.delegate = audioDelegate
                        audioDelegate.onFinish = {
                            DispatchQueue.main.async {
                                withAnimation(.easeInOut) {
                                    self.audioFinished = true
                                }
                            }
                        }
                        speakQuestion()
                    }
                    .transition(.opacity)
                } else {
                    // Display the question text normally with fade transition.
                    Text(questions[currentQuestionIndex].text)
                        .font(.title2)
                        .padding()
                        .transition(.opacity)
                }
            }
            .animation(.easeInOut, value: currentQuestionIndex)

            if let elapsed = elapsedTime {
                Text(String(format: "Time to answer: %.2f seconds", elapsed))
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .padding(.bottom)
                    .transition(.opacity)
            }

            // Only show answer options if the question is not spoken or audio has finished.
            if !questions[currentQuestionIndex].shouldBeSpoken || audioFinished {
                ForEach(questions[currentQuestionIndex].options.indices, id: \.self) { index in
                    let option = questions[currentQuestionIndex].options[index]
                    Button(action: {
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

                        withAnimation(.easeInOut) {
                            if currentQuestionIndex < questions.count - 1 {
                                currentQuestionIndex += 1
                                questionStartTime = Date()
                                elapsedTime = nil
                            } else {
                                statsManager.stats.round2TotalTime = Date().timeIntervalSince(roundStartTime)
                                finished = true
                            }
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
                    .transition(.opacity)
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

//Note to Mathew: Disabled System messages due to them be overcrowed with messages from including voice (It is normal but here is how I did if i need to renable the system messages in the future
// Menu Bar -> Product -> Scheme -> Edit Scheme -> Enviroment Virables -> Uncheck "OS_ACTIVITY_MODE"
