//
//  MovieLookupApp.swift
//  MovieLookup
//
//  Created by Andy Jung on 4/2/2023.
//


import SwiftUI
import FirebaseCore
import UIKit

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

@main
struct MovieLookupApp: App {
    init() {
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithOpaqueBackground()
        tabBarAppearance.backgroundColor = UIColor(Color(red: 39/255, green: 40/255, blue: 59/255))
        tabBarAppearance.stackedLayoutAppearance.normal.iconColor = UIColor(Color(red: 200/255, green: 200/255, blue: 200/255))
        tabBarAppearance.stackedLayoutAppearance.selected.iconColor = UIColor(Color.white)

        UITabBar.appearance().standardAppearance = tabBarAppearance
        UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
    }
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var movieDetailVM = MovieDetailsViewModel()
    @StateObject var movieDiscoverVM = MovieViewModel()
    var body: some Scene {
        WindowGroup {
            LoginView()
                .environmentObject(movieDetailVM)
                .environmentObject(movieDiscoverVM)
                .environmentObject(UserMoviesService.shared)
        }
    }
}
