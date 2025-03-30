//
//  Untitled.swift
//  remember-me
//
//  Created by Mathew Boyd on 2025-03-30.
//

import Foundation
import CoreML

class AlzheimersModelManager: ObservableObject {
    
    private var model: AlzheimersPredictor?
    
    init() {
        // Load the compiled Core ML model
        do {
            let config = MLModelConfiguration()
            self.model = try AlzheimersPredictor(configuration: config)
        } catch {
            print("Error loading AlzheimersPredictor.mlmodel: \(error)")
        }
    }
    
    /// Runs the prediction given a dictionary of feature values.
    func predictDiagnosis(featureDict: [String: Double]) -> String? {
        guard let model = model else {
            print("Model not loaded.")
            return nil
        }
        
        do {
            let input = AlzheimersPredictorInput(
                age: featureDict["age"] ?? 0.0,
                round1Correct: featureDict["round1Correct"] ?? 0.0,
                round2Correct: featureDict["round2Correct"] ?? 0.0,
                round3Correct: featureDict["round3Correct"] ?? 0.0,
                round1AverageResponseTime: featureDict["round1AverageResponseTime"] ?? 0.0,
                round2AverageResponseTime: featureDict["round2AverageResponseTime"] ?? 0.0,
                round3AverageResponseTime: featureDict["round3AverageResponseTime"] ?? 0.0,
                round1TotalTime: featureDict["round1TotalTime"] ?? 0.0,
                round2TotalTime: featureDict["round2TotalTime"] ?? 0.0,
                round3TotalTime: featureDict["round3TotalTime"] ?? 0.0,
                totalCorrect: featureDict["totalCorrect"] ?? 0.0,
                round2AudioReplays: featureDict["round2AudioReplays"] ?? 0.0,
                overallTotalTime: featureDict["overallTotalTime"] ?? 0.0
            )

            let output = try model.prediction(input: input)
            
            let labelMap = [
                0: "no_alzheimers",
                1: "maybe_alzheimers",
                2: "You may have alzheimers"
            ]
            
            let predictedIndex = output.diagnosis_prediction
            return labelMap[Int(predictedIndex)]

        } catch {
            print("Error making prediction: \(error)")
            return nil
        }
    }

}
