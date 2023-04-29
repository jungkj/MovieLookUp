//
//  movieRowView.swift
//  MovieLookup
//
//  Created by Andy Jung on 4/2/23.
//

import SwiftUI

struct MovieRow: View {
    let movie: Movie

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(movie.title)
                .font(.headline)
            Text(movie.overview)
                .font(.subheadline)
                .foregroundColor(.gray)
                .lineLimit(3)
        }
        .padding(.leading, 10) // Adjust this value to your preference
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Color.white)
        .cornerRadius(8)
        .shadow(radius: 4)
        .background(Color.red) // Add this line to see if rows are being displayed
    }
}

struct MovieRow_Previews: PreviewProvider {
    static var exampleMovie: Movie {
        return Movie(adult: false,
                     id: 23834,
                     poster_path: "/path/to/poster",
                     title: "Example Movie",
                     overview: "This is an example movie overview, which should give you an idea of how the movie description will look in the view.",
                     vote_average: 5.5,
                     backdrop_path: "/path/to/backdrop")
    }
    
    static var previews: some View {
        MovieRow(movie: exampleMovie)
    }
}
