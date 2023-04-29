//
//  DiscoverView.swift
//  MovieLookup
//
//  Created by Andy Jung on 4/2/2023.
//


import SwiftUI

struct DiscoverView: View {

    @StateObject var viewModel = MovieViewModel()
    @State var searchText = ""
    @State private var isLiked = false

    var body: some View {
        NavigationStack {
            ScrollView {
                if searchText.isEmpty {
                    if viewModel.trending.isEmpty {
                        Text("No Results")
                    } else {
                        HStack {
                            Text("Trending")
                                .font(.title)
                                .foregroundColor(.white)
                                .fontWeight(.heavy)
                            Spacer()
                        }
                        .padding(.horizontal)
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(viewModel.trending) { trendingItem in
                                    NavigationLink {
                                        MovieDetailView(movie: trendingItem)
                                    } label: {
                                        TrendingCard(trendingItem: trendingItem)
                                    }
                                }
                            }
                            .padding(.horizontal)
                        }
                        
                        Spacer()
                        
                        VStack(alignment: .leading, spacing: 10){
                            Text("What to Watch")
                                .font(.title)
                                .foregroundColor(.white)
                                .fontWeight(.heavy)
                            
                            ScrollView{
                                LazyVStack(alignment: .leading){
                                    ForEach(viewModel.fetch){ movie in
                                        VStack(alignment: .leading){
                                            NavigationLink(destination: MovieDetailView(movie: movie)){
                                                Text(movie.title)
                                                    .foregroundColor(.white)
                                                    .fontWeight(.semibold)
                                            }
                                        }
                                        HStack{NavigationLink(destination:MovieDetailView(movie: movie)){
                                            AsyncImage(url: movie.posterThumbnail){ image in
                                                image
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(width:50, height: 75)
                                                    .cornerRadius(5)
                                            } placeholder: {
                                                ProgressView()
                                                    .frame(width: 50, height: 75)
                                            }
                                        }
                                            
                                            Text(movie.overview)
                                                .foregroundColor(.white)
                                                .lineLimit(5)
                                                .frame(maxWidth: .infinity, alignment: .leading)
                                        }
                                        .clipped()
                                        Divider()
                                            .background(Color.white.opacity(0.4))
                                    }
                                    .foregroundColor(.white)
                                    
                                }

                                
                                
                            }
                            
                        }
                        .padding(.horizontal)
                    }
                } else {
                    LazyVStack() {
                        ForEach(viewModel.searchResults) { movie in
                            HStack {
                                AsyncImage(url: movie.backdropURL) { image in
                                    image
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 80, height: 120)
                                } placeholder: {
                                    ProgressView()
                                        .frame(width: 80, height: 120)
                                }
                                .clipped()
                                .cornerRadius(10)

                                VStack(alignment:.leading) {
                                    Text(movie.title)
                                        .foregroundColor(.white)
                                        .font(.headline)

                                    HStack {
                                        Image(systemName: "hand.thumbsup.fill")
                                        Text(String(format: "%.1f", movie.vote_average))
                                        Spacer()
                                    }
                                    .foregroundColor(.yellow)
                                    .fontWeight(.heavy)
                                }
                                Spacer()
                            }
                            .padding()
                            .background(Color(red:61/255,green:61/255,blue:88/255))
                            .cornerRadius(20)
                            .padding(.horizontal)
                        }
                    }
                }
            }
            .background(Color(red:39/255,green:40/255,blue:59/255).ignoresSafeArea())
        }
        .searchable(text: $searchText)
        
        .onChange(of: searchText) { newValue in
            if newValue.count > 2 {
                viewModel.search(term: newValue)
            }
        }
        .onAppear {
            viewModel.loadTrending()
            viewModel.fetchMovies()
        }
        .environmentObject(UserMoviesService.shared)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        DiscoverView()
    }
}
