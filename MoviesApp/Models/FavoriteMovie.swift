//
//  FavoriteMovie.swift
//  MoviesApp
//
//  Created by Bakar Kharabadze on 6/9/24.
//

import Foundation
import SwiftData

@Model
class FavoriteMovie {
    @Attribute(.unique) var id: Int
    var backdropPath: String?
    var overview: String
    var genreIDs: [Int]
    var posterPath: String?
    var releaseDate: String
    var title: String
    var voteAverage: Double
    
    init(id: Int, backdropPath: String?, overview: String,genreIDs: [Int], posterPath: String?, releaseDate: String, title: String, voteAverage: Double) {
        self.id = id
        self.backdropPath = backdropPath
        self.overview = overview
        self.genreIDs = genreIDs
        self.posterPath = posterPath
        self.releaseDate = releaseDate
        self.title = title
        self.voteAverage = voteAverage
    }
}
