//
//  DailyPlannerView.swift
//  remember-me
//
//  Created by Xiaoya Zou on 2025-03-29.
//

// test by xiaoya

import SwiftUI

struct DailyPlannerView: View {
    @State private var showAddTaskSheet = false
    @State private var tasks: [PlannerTask] = [
        PlannerTask(
            id: UUID().uuidString,
            date: "2025-03-29",
            time: "9:00 AM",
            description: "Take morning medication",
            note: "Daily blood pressure pill",
            category: "Health"
        ),
        PlannerTask(
            id: UUID().uuidString,
            date: "2025-03-29",
            time: "11:00 AM",
            description: "Call Doctor’s office",
            note: "Confirm appointment",
            category: "Health"
        ),
        PlannerTask(
            id: UUID().uuidString,
            date: "2025-03-29",
            time: "4:00 PM",
            description: "Walk around the block",
            note: "30 min walk",
            category: "Exercise"
        )
    ]
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 24) {

                // Section: Add New Task (just opens sheet now)
                VStack(alignment: .leading, spacing: 12) {
                    Text("Add New Task")
                        .font(.headline)

                    Button("Open Add Task Sheet") {
                        showAddTaskSheet = true
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
        .sheet(isPresented: $showAddTaskSheet) {
            AddTaskView(tasks: $tasks)
        }
    }
}



#Preview {
    DailyPlannerView()
}
