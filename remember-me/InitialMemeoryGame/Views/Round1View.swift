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
    
    let questions = Questions.round1

    var body: some View {
            VStack {
                
                // Dummy image placeholder (replace with an actual image if available)
                Rectangle()
                    .fill(Color.green.opacity(0.3))
                    .frame(height: 200)
                    .overlay(Text("Image Placeholder").foregroundColor(.black))
                    .padding()
                
                Spacer()
                
                Text(questions[currentQuestionIndex].text)
                    .padding()
                VStack{
                    ForEach(questions[currentQuestionIndex].options, id: \.self) { option in
                        Button(action: {
                            let logMessage = "Round1 Q\(currentQuestionIndex+1): Selected: \(option)"
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
                    }
                    Spacer()
                    .toolbar {
                        ToolbarItem(placement: .principal) {
                            CustomTitleView(title: "Round 1: Attention & Visual Search")
                        }
                    }
                }
                
                // This NavigationLink will only work if there's a NavigationView or NavigationStack above
                NavigationLink(
                    destination: Round2View()
                        .environmentObject(metricsLogger),
                    isActive: $finished
                ) {
                    EmptyView()
                }
            }
            .navigationBarBackButtonHidden(true)
        }

}

struct Round1View_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            Round1View().environmentObject(MetricsLogger())
        }
    }
}


