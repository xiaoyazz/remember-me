//
//  HomeView.swift
//  remember-me
//
//  Created by Xiaoya Zou on 2025-03-29.
//

import SwiftUI

struct DailyTask: Identifiable {
    let id = UUID()
    let time: String
    let activities: [String]
    let color: Color
}

struct HomeView: View {
    @State private var selectedDate = Calendar.current.component(.day, from: Date())

    let days = (0..<7).map { offset in
        Calendar.current.date(byAdding: .day, value: offset, to: Date())!
    }

    let dailySchedule: [DailyTask] = [
        DailyTask(time: "8:00 AM", activities: ["Brush teeth"], color: .yellow),
        DailyTask(time: "11:00 AM", activities: ["Medications"], color: .gray),
        DailyTask(time: "1:00 PM", activities: ["Lunch"], color: .pink),
        DailyTask(time: "3:00 PM", activities: ["Nap"], color: .blue),
        DailyTask(time: "5:00 PM", activities: ["Dinner"], color: .green)
    ]

    var body: some View {
        TabView {
            NavigationStack {
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        // Header
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Home")
                                .font(.largeTitle)
                                .bold()

                            Text("Good morning!")
                                .font(.title2)
                                .bold()
                        }

                        // Calendar Scroll
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 12) {
                                ForEach(days, id: \.self) { day in
                                    let dayNumber = Calendar.current.component(.day, from: day)
                                    let isToday = Calendar.current.isDateInToday(day)
                                    VStack {
                                        Text(day.formatted(.dateTime.weekday(.abbreviated)))
                                        Text("\(dayNumber)")
                                            .bold()
                                    }
                                    .frame(width: 60, height: 60)
                                    .background(isToday ? Color.green : Color.gray.opacity(0.2))
                                    .foregroundColor(isToday ? .white : .black)
                                    .cornerRadius(16)
                                    .onTapGesture {
                                        selectedDate = dayNumber
                                    }
                                }
                            }
                        }

                        // Memory Games
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Memory Games")
                                .font(.headline)
                            
                            VStack(spacing: 12) {
                                Label("Family Photo Gallery", systemImage: "photo")
                                    .padding()
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .background(Color.gray.opacity(0.1))
                                    .cornerRadius(12)
                                
                                Label("Meet My Pet", systemImage: "pawprint")
                                    .padding()
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .background(Color.gray.opacity(0.1))
                                    .cornerRadius(12)
                            }
                        }

                        // Today's Tasks
                        VStack(alignment: .leading, spacing: 16) {
                            Text("Today's Tasks")
                                .font(.headline)

                            ForEach(dailySchedule) { task in
                                VStack(alignment: .leading, spacing: 10) {
                                    Text(task.time)
                                        .font(.subheadline)
                                        .bold()
                                        .foregroundColor(.primary)

                                    ForEach(task.activities, id: \.self) { activity in
                                        HStack {
                                            Circle()
                                                .fill(task.color)
                                                .frame(width: 8, height: 8)
                                            Text(activity)
                                                .font(.body)
                                                .foregroundColor(.primary)
                                        }
                                    }
                                }
                                .padding()
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(task.color.opacity(0.15))
                                .cornerRadius(16)
                            }
                        }

                    }
                    .padding()
                }
            }
            .tabItem {
                Label("Home", systemImage: "house")
            }

            // Other Tabs
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.circle")
                }

            MemoryGamesView()
                .tabItem {
                    Label("Games", systemImage: "gamecontroller")
                }

            HealthView()
                .tabItem {
                    Label("Health", systemImage: "heart")
                }

            DailyPlannerView()
                .tabItem {
                    Label("Planner", systemImage: "calendar")
                }

            SOSView()
                .tabItem {
                    Label("SOS", systemImage: "exclamationmark.triangle")
                }
        }
    }
}


#Preview {
    HomeView()
}
