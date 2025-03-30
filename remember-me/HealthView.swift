//
//  HealthView.swift
//  remember-me
//
//  Created by Xiaoya Zou on 2025-03-29.
//

import SwiftUI

struct HealthView: View {
    
    @ObservedObject var manager = HealthDataManager.shared
    
    // Mocked data
    let heartRate = 72
    let lastFallDetected = "2 days ago"
    let medicationTakenToday = true
    let stepsToday = 1450
    let hydrationLevel = "Moderate"
    let sleepQuality = "Light Sleep (5h 12m)"
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                Text("Health Summary")
                    .font(.largeTitle)
                    .bold()
                
                // Heart Rate
                HStack {
                    Image(systemName: "heart.fill")
                        .foregroundColor(.red)
                    VStack(alignment: .leading) {
                        Text("Heart Rate")
                            .font(.headline)
                        Text("\(manager.heartRate) BPM")
                            .font(.title2)
                            .bold()
                    }
                    Spacer()
                }
                // Fall Detection
                HStack {
                    Image(systemName: "figure.fall")
                        .foregroundColor(.orange)
                    VStack(alignment: .leading) {
                        Text("Last Fall Detected")
                            .font(.headline)
                        Text(manager.lastFallDetected)
                    }
                    Spacer()
                }

                // Medication
                HStack {
                    Image(systemName: "pills.fill")
                        .foregroundColor(.purple)
                    VStack(alignment: .leading) {
                        Text("Medication Taken Today")
                            .font(.headline)
                        Text(medicationTakenToday ? "Yes" : "Not Yet")
                            .foregroundColor(medicationTakenToday ? .green : .red)
                    }
                    Spacer()
                }

                // Steps Count
                HStack {
                    Image(systemName: "figure.walk")
                        .foregroundColor(.blue)
                    VStack(alignment: .leading) {
                        Text("Steps Today")
                            .font(.headline)
                        Text("\(stepsToday) steps")
                    }
                    Spacer()
                }

                // Hydration
                HStack {
                    Image(systemName: "drop.fill")
                        .foregroundColor(.cyan)
                    VStack(alignment: .leading) {
                        Text("Hydration Level")
                            .font(.headline)
                        Text(hydrationLevel)
                    }
                    Spacer()
                }

                // Sleep
                HStack {
                    Image(systemName: "bed.double.fill")
                        .foregroundColor(.indigo)
                    VStack(alignment: .leading) {
                        Text("Last Night’s Sleep")
                            .font(.headline)
                        Text(sleepQuality)
                    }
                    Spacer()
                }
            }
            .padding()
            .onAppear {
                manager.sendMockHealthDataToWatch()
            }
        }
    }
}

#Preview {
    HealthView()
}
