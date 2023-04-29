//
//  savedMovie.swift
//  MovieLookup
//
//  Created by Andy Jung on 4/2/23.
//

import Foundation
import FirebaseFirestoreSwift

struct savedMovie: Identifiable, Codable{
    @DocumentID var id: String?
    var title = ""
    var movie_id: Int?
    
}
