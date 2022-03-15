//
//  CryptoTrackerApp.swift
//  CryptoTracker
//
//  Created by Mehdi MMS on 11/03/2022.
//

import SwiftUI

@main
struct CryptoTrackerApp: App {
    var body: some Scene {
        
        WindowGroup {
            NavigationView {
                HomeView()
                    .navigationBarHidden(true)
            }
        }
    }
}
