//
//  AddTaskView.swift
//  remember-me
//
//  Created by Mathew Boyd on 2025-03-30.
//
import SwiftUI

struct AddTaskView: View {
    @Binding var tasks: [PlannerTask]
    
    @Environment(\.dismiss) private var dismiss
    
    @State private var newTaskTime: String = ""
    @State private var newTaskDescription: String = ""
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Time")) {
                    TextField("e.g. 9:00 AM", text: $newTaskTime)
                }
                Section(header: Text("Description")) {
                    TextField("Task Description", text: $newTaskDescription)
                }
                Button("Add Task") {
                    guard !newTaskTime.isEmpty && !newTaskDescription.isEmpty else { return }
                    let newTask = PlannerTask(
                        id: UUID().uuidString,
                        date: currentDate(),
                        time: newTaskTime,
                        description: newTaskDescription,
                        note: nil,
                        category: nil
                    )
                    tasks.append(newTask)
                    dismiss() // close sheet
                }
            }
            .navigationTitle("Add Task")
        }
    }
    
    private func currentDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: Date())
    }
}


