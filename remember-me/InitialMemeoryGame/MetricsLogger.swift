//
//  MetricsLogger.swift
//  remember-me
//
//  Created by Mathew Boyd on 2025-03-29.
//

import Foundation
import SwiftUI

class MetricsLogger: ObservableObject {
    @Published var logs: [String] = []
    
    func log(_ message: String) {
        logs.append(message)
        print(message)
    }
}
