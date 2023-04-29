//
//  fetchResults.swift
//  MovieLookup
//
//  Created by Andy Jung on 4/2/23.
//


struct MovieApiResponse: Decodable {
    let results: [Movie]
}
