//
//  savedMoviesViewModel.swift
//  MovieLookup
//
//  Created by Andy Jung on 4/2/23.
//

import SwiftUI
import Combine

@MainActor
class SavedMoviesViewModel: ObservableObject {
    @Published var savedMovies: [Movie] = []

    private var cancellables = Set<AnyCancellable>()

    init() {
        fetchSavedMovies()
    }

    private func fetchSavedMovies() {
        UserMoviesService.shared.getLikedMovies { movies in
            DispatchQueue.main.async {
                self.savedMovies = movies
            }
        }
    }
}
