//
//  Round2View.swift
//  remember-me
//
//  Created by Mathew Boyd on 2025-03-29.
//

import SwiftUI

import SwiftUI

struct Round2View: View {
    @EnvironmentObject var metricsLogger: MetricsLogger
    @State private var currentQuestionIndex = 0

    let questions = Questions.round2

    var body: some View {
        VStack {
            Text("Round 2: Cognitive Ability")
                .font(.title)
                .padding()
            
            Text(questions[currentQuestionIndex].text)
                .padding()
            
            ForEach(questions[currentQuestionIndex].options, id: \.self) { option in
                Button(action: {
                    let logMessage = "Round2 Q\(currentQuestionIndex+1): Selected: \(option)"
                    metricsLogger.log(logMessage)
                    if currentQuestionIndex < questions.count - 1 {
                        currentQuestionIndex += 1
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
        .navigationTitle("Round 2")
    }
}

struct Round2View_Previews: PreviewProvider {
    static var previews: some View {
        Round2View().environmentObject(MetricsLogger())
    }
}
