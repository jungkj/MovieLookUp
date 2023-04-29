//
//  TrendingCard.swift
//  MovieLookup
//
//  Created by Andy Jung on 4/2/2023.
//

import Foundation
import SwiftUI

struct TrendingCard: View {

    let trendingItem: Movie
    @EnvironmentObject var userMoviesService: UserMoviesService
    
    
    var body: some View {
        ZStack(alignment: .bottom) {
            AsyncImage(url: trendingItem.backdropURL) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: 340, height: 240)
            } placeholder: {
                Rectangle().fill(Color(red:61/255,green:61/255,blue:88/255))
                        .frame(width: 340, height: 240)
            }
            
            VStack {
                HStack {
                    Text(trendingItem.title)
                        .foregroundColor(.white)
                        .fontWeight(.heavy)
                    Spacer()

                    Button(action: {
                        userMoviesService.toggleLike(for: trendingItem)
                    }) {
                        Image(systemName: userMoviesService.isLiked(movie: trendingItem) ? "heart.fill" : "heart")
                            .resizable()
                            .frame(width: 28, height: 24)
                            .foregroundColor(userMoviesService.isLiked(movie: trendingItem) ? .red : .white)
                            .shadow(color: .black, radius: 2, x: 0, y: 0)
                    }
                    .padding()
                }
                HStack {
                    Image(systemName: "hand.thumbsup.fill")
                    Text(String(format: "%.1f", trendingItem.vote_average))
                    Spacer()
                }
                .foregroundColor(.yellow)
                .fontWeight(.heavy)
            }
            .padding()
            .background(Color(red:61/255,green:61/255,blue:88/255))
        }
        .cornerRadius(10)
    }
    
}



