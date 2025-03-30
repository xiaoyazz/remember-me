//
//  remember_meApp.swift
//  remember-me
//
//  Created by Xiaoya Zou on 2025-03-28.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}


@main
struct remember_meApp: App {
    
    @State private var isLoggedIn = false
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            SplashView(isLoggedIn: $isLoggedIn)
            //suMainMemeoryView()
        }
    }
}
