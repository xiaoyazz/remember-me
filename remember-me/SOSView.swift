//
//  SOSView.swift
//  remember-me
//
//  Created by Xiaoya Zou on 2025-03-29.
//

// test by xiaoya//

import SwiftUI
import MapKit

struct SOSView: View {
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 43.6532, longitude: -79.3832),
        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
    )

    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                // Section 1: Who Am I
                VStack(alignment: .leading, spacing: 12) {
                    Text("Who Am I")
                        .font(.headline)
                    Text("Name: Jane Doe\nAge: 76\nMedical Conditions: Alzheimer’s\nAllergies: Penicillin\nAddress: 123 Main Street, Toronto, ON M4E 2V9")
                        .font(.body)
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color.green.opacity(0.1))
                        .cornerRadius(12)
                }

                // Section 2: Call 911
                Button(action: {
                    print("Calling 911...")
                }) {
                    HStack {
                        Image(systemName: "phone.fill")
                        Text("Call 911")
                            .bold()
                    }
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.red)
                    .cornerRadius(12)
                }

                // Section 3: Call Emergency Contact
                Button(action: {
                    print("Calling emergency contact...")
                }) {
                    HStack {
                        Image(systemName: "person.crop.circle.badge.exclamationmark")
                        Text("Call Emergency Contact")
                            .bold()
                    }
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.orange)
                    .cornerRadius(12)
                }

                // Map Section
                VStack(alignment: .leading) {
                    Text("Current Location")
                        .font(.headline)

                    Map(coordinateRegion: $region)
                        .frame(height: 200)
                        .cornerRadius(12)
                }

                Spacer()
            }
            .padding()
            .navigationTitle("Emergency Help")
        }
    }
}

#Preview {
    SOSView()
}
