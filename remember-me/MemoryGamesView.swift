//
//  MemoryGamesView.swift
//  remember-me
//
//  Created by Xiaoya Zou on 2025-03-29.
//

import SwiftUI

struct MemoryGamesView: View {
    var body: some View {
        NavigationStack {
            List {
                Section(header: Text("Family & Pets")) {
                    NavigationLink(destination: Text("Comming soon...")) {
                        Label("Faces I Love", systemImage: "photo")
                    }
                    
                    NavigationLink(destination: Text("Coming soon...")) {
                        Label("My Furry Friends", systemImage: "pawprint")
                    }
                }
                
                Section(header: Text("Life")) {
                    NavigationLink(destination: Text("Coming soon...")) {
                        Label("Where I live", systemImage: "building.2")
                    }

                    NavigationLink(destination: Text("Coming soon...")) {
                        Label("This Is Me", systemImage: "book.closed")
                    }
                }
                
                Section(header: Text("Entertainment")) {
                    NavigationLink(destination: Text("Coming soon...")) {
                        Label("Musical Memories", systemImage: "music.note")
                    }

                    NavigationLink(destination: Text("Coming soon...")) {
                        Label("My Sports Days", systemImage: "sportscourt")
                    }
                }
                
            }
            .navigationTitle("Memory Games")
        }
    }
}


#Preview {
    MemoryGamesView()
}
