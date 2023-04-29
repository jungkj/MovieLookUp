//
//  MovieDiscoverViewModel.swift
//  MovieLookup
//
//  Created by Andy Jung on 4/2/2023.
//

import Foundation

@MainActor
class MovieViewModel: ObservableObject {

    @Published var trending: [Movie] = []
    @Published var searchResults: [Movie] = []
    @Published var fetch: [Movie] = []

    let apiKey = "adeefc9efe51bda1eb5861bb81f5bfea"
   
    func loadTrending() {
        Task {
            let url = URL(string: "https://api.themoviedb.org/3/trending/movie/day?api_key=\(apiKey)")!
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                let trendingResults = try JSONDecoder().decode(TrendingResults.self, from: data)
                trending = trendingResults.results
            } catch {
                print(error)
            }
        }
    }

    func search(term: String) {
        Task {
            let url = URL(string: "https://api.themoviedb.org/3/search/movie?api_key=\(apiKey)&language=en-US&page=1&include_adult=false&query=\(term)".addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)!)!
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                let search = try JSONDecoder().decode(TrendingResults.self, from: data)
                searchResults = search.results
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func fetchMovies() {
        Task {
            let url = URL(string: "https://api.themoviedb.org/3/discover/movie?api_key=adeefc9efe51bda1eb5861bb81f5bfea&language=en-US&sort_by=popularity.desc&page=1".addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)!)!
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                let result = try JSONDecoder().decode(MovieApiResponse.self, from: data)
                fetch = result.results
            } catch {
                print(error.localizedDescription)
            }
        }
    }


}
