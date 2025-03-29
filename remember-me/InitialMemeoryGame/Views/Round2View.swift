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
    
    // Use round2 questions from the Questions struct.
    let questions = Questions.round2

    var body: some View {
        VStack {

            Text(questions[currentQuestionIndex].text)
                .padding()
                .font(.title3)
            
            ForEach(questions[currentQuestionIndex].options, id: \.self) { option in
                Button(action: {
                    let logMessage = "Round2 Q\(currentQuestionIndex+1): Selected: \(option)"
                    metricsLogger.log(logMessage)
                    
                    if currentQuestionIndex < questions.count - 1 {
                        currentQuestionIndex += 1
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
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        CustomTitleView(title: "Round 2: Cognitive Ability")
                    }
                }
            }
        
            
            NavigationLink(destination: Round3View().environmentObject(metricsLogger),
                           isActive: $finished) {
                EmptyView()
            }
        }
        .navigationBarBackButtonHidden(true)

    }
}

struct Round2View_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            Round2View().environmentObject(MetricsLogger())
        }
    }
}
