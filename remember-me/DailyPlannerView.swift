//
//  DailyPlannerView.swift
//  remember-me
//
//  Created by Xiaoya Zou on 2025-03-29.
//

// test by xiaoya

import SwiftUI

struct DailyPlannerView: View {
    @State private var tasks: [PlannerTask] = []
    @State private var newTaskTime: String = ""
    @State private var newTaskDescription: String = ""

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 24) {

                // Section: Add New Task
                VStack(alignment: .leading, spacing: 12) {
                    Text("Add New Task")
                        .font(.headline)

                    TextField("Time (e.g. 9:00 AM)", text: $newTaskTime)
                        .textFieldStyle(RoundedBorderTextFieldStyle())

                    TextField("Task Description", text: $newTaskDescription)
                        .textFieldStyle(RoundedBorderTextFieldStyle())

                    Button("Add Task") {
                        if !newTaskTime.isEmpty && !newTaskDescription.isEmpty {
                            let newTask = PlannerTask(
                                id: UUID().uuidString,
                                date: formattedDate(),
                                time: newTaskTime,
                                description: newTaskDescription,
                                note: nil,
                                category: nil
                            )
                            tasks.append(newTask)
                            newTaskTime = ""
                            newTaskDescription = ""
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.accentColor)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                }

                Divider()

                // Section: Scheduled Tasks
                VStack(alignment: .leading, spacing: 16) {
                    Text("Today's Tasks")
                        .font(.headline)

                    ForEach(tasks) { task in
                        VStack(alignment: .leading, spacing: 4) {
                            Text(task.time)
                                .font(.subheadline)
                                .bold()

                            Text(task.description)
                                .font(.body)
                        }
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(12)
                    }
                }

                Spacer()
            }
            .padding()
            .navigationTitle("Daily Planner")
        }
    }

    private func formattedDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: Date())
    }
}

#Preview {
    DailyPlannerView()
}
