//
//  MovieDetailView.swift
//  MovieLookup
//
//  Created by Andy Jung on 4/2/2023.
//

import Foundation
import SwiftUI

struct MovieDetailView: View {
    
    
    @Environment(\.dismiss) var dismiss
    @StateObject var model = MovieDetailsViewModel()
    @EnvironmentObject var userMoviesService: UserMoviesService
    let movie: Movie
    let headerHeight: CGFloat = 400
    
    var body: some View {
        ZStack {
            Color(red:39/255,green:40/255,blue:59/255).ignoresSafeArea()
            
            GeometryReader { geo in
                VStack {
                    AsyncImage(url: movie.backdropURL) { image in
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(maxWidth: geo.size.width, maxHeight: headerHeight)
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                    } placeholder: {
                        ProgressView()
                    }
                    Spacer()
                }
            }
            
            ScrollView {
                VStack(spacing: 12) {
                    Spacer()
                        .frame(height: headerHeight)
                    HStack {
                        Text(movie.title)
                            .font(.title)
                            .foregroundColor(.white)
                            .fontWeight(.heavy)
                        Spacer()
                        
                        Button(action: {
                            userMoviesService.toggleLike(for: movie)
                        }) {
                            Image(systemName: userMoviesService.isLiked(movie: movie) ? "heart.fill" : "heart")
                                .resizable()
                                .frame(width: 28, height: 24)
                                .foregroundColor(userMoviesService.isLiked(movie: movie) ? .red : .white)
                                .shadow(color: .black, radius: 2, x: 0, y: 0)
                        }
                        
                    }
                    
                    
                    HStack {
                        Text("About film")
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                        Spacer()
                    }
                    
                    Text(movie.overview)
                        .lineLimit(2)
                        .foregroundColor(.white)
                    
                    HStack {
                        Text("Cast & Crew")
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                        Spacer()
                    }
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHStack {
                            ForEach(model.castProfiles) { cast in
                                CastView(cast: cast)
                            }
                        }
                    }
                }
                .padding()
            }
        }
        .ignoresSafeArea()
        .overlay(alignment: .topLeading) {
            Button {
                dismiss()
            } label: {
                Image(systemName: "chevron.left")
                    .imageScale(.large)
                    .fontWeight(.bold)
            }
            .padding(.leading)
        }
        .toolbar(.hidden, for: .navigationBar)
        .task {
            await model.movieCredits(for: movie.id)
            await model.loadCastProfiles()
        }
        .environmentObject(UserMoviesService.shared)
    }
}

struct MovieDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailView(movie: .preview)
            .environmentObject(UserMoviesService.shared)
    }
}

