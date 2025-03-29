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


    let questions = Questions.round1

    var body: some View {
        VStack {
            Text("Round 1: Attention & Visual Search")
                .font(.title)
                .padding()
            
            // Dummy image placeholder 
            Rectangle()
                .fill(Color.green.opacity(0.3))
                .frame(height: 200)
                .overlay(Text("Image Placeholder").foregroundColor(.black))
                .padding()
            
            Text(questions[currentQuestionIndex].text)
                .padding()
            
            //Creating a button for each of the options
            ForEach(questions[currentQuestionIndex].options, id: \.self) { option in
                Button(action: {
                    let logMessage = "Round1 Q\(currentQuestionIndex+1): Selected: \(option)"
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
        .navigationTitle("Round 1")
    }
}

struct Round1View_Previews: PreviewProvider {
    static var previews: some View {
        Round1View().environmentObject(MetricsLogger())
    }
}
