//
//  AppConfig.swift
//  CryptoTracker
//
//  Created by Mehdi MMS on 25/03/2022.
//

import SwiftUI
import Foundation

/// Generic configurations for the app
class AppConfig {
    
    /// This is the AdMob Interstitial ad id
    /// Test App ID: ca-app-pub-3940256099942544~1458002511
    static let adMobAdId: String = "ca-app-pub-7083407941877631~3121381968"
    static let adMobFrequency: Int = 3 /// every 3 document views
    
    // MARK: - Default folders
    static let allFilesFolderName: String = "All Files"
    static let workCustomDefaultFolderName: String = "Work Stuff"
    
    // MARK: - Terms and Privacy
    static let termsURL: URL = URL(string: "https://www.crypttracker.app/home")!
    static let privacyURL: URL = URL(string: "https://www.crypttracker.app/home")!
    
    // MARK: - In App Purchases
    static let premiumVersion: String = "1988779873"
    static let freePlanScansCount: Int = 2
    
    /// Your email for support
    static let emailSupport = "info@crypttracker.app"
    static let yourAppURL: URL = URL(string: "")!
}
