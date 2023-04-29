//
//  savedMoviesView.swift
//  MovieLookup
//
//  Created by Andy Jung on 4/2/23.
//

import SwiftUI

struct savedMoviesView: View {
    @EnvironmentObject var userMoviesService: UserMoviesService

    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading) {
                ForEach(userMoviesService.likedMovies) { movie in
                    VStack(alignment: .leading) {
                        Text(movie.title)
                            .foregroundColor(.white)
                            .fontWeight(.semibold)
                    }
                    HStack {
                        AsyncImage(url: movie.posterThumbnail) { image in
                            image
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 75)
                                .cornerRadius(5)
                        } placeholder: {
                            ProgressView()
                                .frame(width: 50, height: 75)
                        }

                        Text(movie.overview)
                            .foregroundColor(.white)
                            .lineLimit(5)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .clipped()
                    Divider()
                        .background(Color.white.opacity(0.2))
                }
                .foregroundColor(.white)
            }
        }
        .padding(.horizontal)
        .background(Color(red: 39/255, green: 40/255, blue: 59/255).ignoresSafeArea())
        .navigationTitle("Saved Movies")
    }
}

struct SavedMoviesView_Previews: PreviewProvider {
    static var previews: some View {
        savedMoviesView()
            .environmentObject(UserMoviesService.shared)
    }
}
