//
//  UserMoviesServices.swift
//  MovieLookup
//
//  Created by Andy Jung on 4/2/23.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class UserMoviesService: ObservableObject{
    static let shared = UserMoviesService()
    @Published var likedMovies: [Movie] = []
    
    init() {
        getLikedMovies { (movies) in
            self.likedMovies = movies
        }
    }


    func getLikedMovies(completion: @escaping ([Movie]) -> Void) {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        let db = Firestore.firestore()
        db.collection("users").document(userId).collection("likedMovies").getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error getting liked movies: \(error)")
                completion([])
            } else {
                var movies: [Movie] = []
                for document in querySnapshot!.documents {
                    let data = document.data()
                    let movie = Movie(adult: false,
                                      id: data["id"] as! Int,
                                      poster_path: data["poster_path"] as? String,
                                      title: data["title"] as! String,
                                      overview: data["overview"] as! String,
                                      vote_average: data["vote_average"] as! Float,
                                      backdrop_path: data["backdrop_path"] as? String)
                    movies.append(movie)
                }
                completion(movies)
            }
        }
    }
    
    func removeLikedMovie(movieId: Int) {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        let db = Firestore.firestore()
        let movieRef = db.collection("users").document(userId).collection("likedMovies").document("\(movieId)")
        movieRef.delete()
    }

    func saveLikedMovie(movie: Movie) {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        let db = Firestore.firestore()
        let movieRef = db.collection("users").document(userId).collection("likedMovies").document("\(movie.id)")
        movieRef.setData([
            "id": movie.id,
            "title": movie.title,
            "poster_path": movie.poster_path ?? "",
            "overview": movie.overview,
            "vote_average": movie.vote_average,
            "backdrop_path": movie.backdrop_path ?? ""
        ])
    }
    
    
    func toggleLike(for movie: Movie) {
        if let index = likedMovies.firstIndex(where: { $0.id == movie.id }) {
            // If the movie is already liked, remove it from the likedMovies list and Firestore
            likedMovies.remove(at: index)
            removeLikedMovie(movieId: movie.id)
        } else {
            // If the movie is not liked yet, add it to the likedMovies list and Firestore
            likedMovies.append(movie)
            saveLikedMovie(movie: movie)
        }
    }

    func isLiked(movie: Movie) -> Bool {
        return likedMovies.contains(where: { $0.id == movie.id })
    }
}
