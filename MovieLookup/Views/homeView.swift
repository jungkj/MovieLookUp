//
//  homeView.swift
//  MovieLookup
//
//  Created by Andy Jung on 4/2/23.
//

import SwiftUI

struct homeView: View {
    var body: some View {
        TabView {
            DiscoverView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Discover")
                }
                .onAppear {
                    UITabBar.appearance().barTintColor = UIColor(Color(red: 39/255, green: 40/255, blue: 59/255))
                }

            savedMoviesView()
                .tabItem {
                    Image(systemName: "heart")
                    Text("Saved")
                }
                .onAppear {
                    UITabBar.appearance().barTintColor = UIColor(Color(red: 39/255, green: 40/255, blue: 59/255))
                }
        }
    }
}

struct homeView_Previews: PreviewProvider {
    static var previews: some View {
        homeView()
            .environmentObject(UserMoviesService.shared)
    }
}
