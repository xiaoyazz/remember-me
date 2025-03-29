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
    @State private var finished = false
    
    // Use round3 questions from the Questions struct.
    let questions = Questions.round3

    var body: some View {
        VStack {
            
            Text(questions[currentQuestionIndex].text)
                .padding()
            
            ForEach(questions[currentQuestionIndex].options, id: \.self) { option in
                Button(action: {
                    let logMessage = "Round3 Q\(currentQuestionIndex+1): Selected: \(option)"
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
        
            
            NavigationLink(destination: FinalView().environmentObject(metricsLogger),
                           isActive: $finished) {
                EmptyView()
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct Round3View_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            Round3View().environmentObject(MetricsLogger())
        }
    }
}
