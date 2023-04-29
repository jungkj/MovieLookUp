//
//  MovieLookupApp.swift
//  MovieLookup
//
//  Created by Andy Jung on 2/4/2023.
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
struct MovieLookupApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var movieDetailVM = MovieDetailsViewModel()
    @StateObject var movieDiscoverVM = MovieDiscoverViewModel()
    var body: some Scene {
        WindowGroup {
            LoginView()
                .environmentObject(movieDetailVM)
                .environmentObject(movieDiscoverVM)
        }
    }
}
