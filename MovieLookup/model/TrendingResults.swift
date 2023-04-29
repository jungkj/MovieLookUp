//
//  TrendingResults.swift
//  MovieLookup
//
//  Created by Andy Jung on 4/2/2023.
//

import Foundation


struct TrendingResults: Decodable {
    let page: Int
    let results: [Movie]
    let total_pages: Int
    let total_results: Int
}
