//
//  CryptoTrackerApp.swift
//  CryptoTracker
//
//  Created by Mehdi MMS on 11/03/2022.
//

import SwiftUI
import GoogleMobileAds

@main
struct SwiftfulCryptoApp: App {
    
    @StateObject private var vm = HomeViewModel()
    @State private var showLaunchView: Bool = true

    init() {
        UINavigationBar
            .appearance()
            .largeTitleTextAttributes = [.foregroundColor : UIColor(Color.theme.accent) ]
        UINavigationBar
            .appearance()
            .titleTextAttributes = [.foregroundColor : UIColor(Color.theme.accent) ]
        UINavigationBar
            .appearance()
            .tintColor = UIColor(Color.theme.accent)
        UITableView
            .appearance()
            .backgroundColor = UIColor.clear
    }
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                NavigationView {
                    HomeView()
                        .navigationBarHidden(true)
                }
                .navigationViewStyle(StackNavigationViewStyle())
                .environmentObject(vm)

                ZStack {
                    if showLaunchView {
                        LaunchView(showLaunchView: $showLaunchView)
                            .transition(.move(edge: .leading))
                    }
                }
                .zIndex(2.0)
            }
        }
    }
}

class Interstitial: NSObject, GADFullScreenContentDelegate {
    @AppStorage("isPremiumUser") var isPremiumUser: Bool = false
    private var interstitial: GADInterstitialAd?
    private var presentedCount: Int = 0
    
    /// Default initializer of interstitial class
    override init() {
        super.init()
        if isPremiumUser == false {
            loadInterstitial()
        }
    }
    
    /// Request AdMob Interstitial ads
    func loadInterstitial() {
        let request = GADRequest()
        GADInterstitialAd.load(withAdUnitID: AppConfig.adMobAdId, request: request, completionHandler: { [self] ad, error in
            if ad != nil { interstitial = ad }
            interstitial?.fullScreenContentDelegate = self
        })
    }
    
    func showInterstitialAds() {
        presentedCount += 1
        if self.interstitial != nil, presentedCount % AppConfig.adMobFrequency == 0, !isPremiumUser {
            var root = UIApplication.shared.windows.first?.rootViewController
            if let presenter = root?.presentedViewController { root = presenter }
            self.interstitial?.present(fromRootViewController: root!)
        }
    }
    
    func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        loadInterstitial()
    }
}
