//
//  Round3View.swift
//  remember-me
//
//  Created by Mathew Boyd on 2025-03-29.
//

import SwiftUI

struct Round3View: View {
    @EnvironmentObject var metricsLogger: MetricsLogger
    @State private var currentQuestionIndex = 0
    
    // Use round3 questions from the Questions struct.
    let questions = Questions.round3
    
    var body: some View {
        VStack {
            Text("Round 3: Executive Function & Multi-Tasking")
                .font(.title)
                .padding()
            
            Text(questions[currentQuestionIndex].text)
                .padding()
            
            ForEach(questions[currentQuestionIndex].options, id: \.self) { option in
                Button(action: {
                    let logMessage = "Round3 Q\(currentQuestionIndex+1): Selected: \(option)"
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
        .navigationTitle("Round 3")
    }
}

struct Round3View_Previews: PreviewProvider {
    static var previews: some View {
        Round3View().environmentObject(MetricsLogger())
    }
}
