//
//  remember_meApp.swift
//  remember-me
//
//  Created by Xiaoya Zou on 2025-03-28.
//

import SwiftUI

@main
struct remember_meApp: App {
    
    @State private var isLoggedIn = false
    
    var body: some Scene {
        WindowGroup {
            SplashView(isLoggedIn: $isLoggedIn)
        }
    }
}
