//
//  HealthDataManager.swift
//  remember-me
//
//  Created by Xiaoya Zou on 2025-03-30.
//

import Foundation
import WatchConnectivity

class HealthDataManager: NSObject, ObservableObject, WCSessionDelegate {
    static let shared = HealthDataManager()

    @Published var heartRate: Int = 72
    @Published var lastFallDetected: String = "2 days ago"

    override private init() {
        super.init()
        if WCSession.isSupported() {
            WCSession.default.delegate = self
            WCSession.default.activate()
        }
    }

    func sendMockHealthDataToWatch() {
        if WCSession.default.isReachable {
            let data: [String: Any] = [
                "heartRate": heartRate,
                "lastFallDetected": lastFallDetected
            ]
            WCSession.default.sendMessage(data, replyHandler: nil, errorHandler: nil)
        }
    }
    
    // Called when receiving a message from the Watch
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        DispatchQueue.main.async {
            if let rate = message["heartRate"] as? Int {
                self.heartRate = rate
            }
            if let fall = message["lastFall"] as? String {
                self.lastFallDetected = fall
            }
        }
    }

    // Required
    func sessionDidBecomeInactive(_ session: WCSession) {}
    func sessionDidDeactivate(_ session: WCSession) {}
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {}
}
