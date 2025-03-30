//
//  ContentView.swift
//  RememberMeWatch Watch App
//
//  Created by Xiaoya Zou on 2025-03-30.
//

import SwiftUI
import WatchConnectivity

class WatchHealthManager: NSObject, ObservableObject, WCSessionDelegate {
    @Published var heartRate: Int = 72
    @Published var lastFallDetected: String = "2"
    override init() {
        super.init()
        if WCSession.isSupported() {
            WCSession.default.delegate = self
            WCSession.default.activate()
        }
    }

    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        DispatchQueue.main.async {
            if let hr = message["heartRate"] as? Int {
                self.heartRate = hr
            }
            if let fall = message["lastFallDetected"] as? String {
                self.lastFallDetected = fall
            }
        }
    }

    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) { }
}

struct ContentView: View {
    @StateObject var manager = WatchHealthManager()

    var body: some View {
        VStack {
            Text("Heart Rate: \(manager.heartRate) BPM")
            Text("Last Fall: \(manager.lastFallDetected)")
        }
    }
}


#Preview {
    ContentView()
}
