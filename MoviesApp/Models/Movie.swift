//
//  Movie.swift
//  MoviesApp
//
//  Created by Bakar Kharabadze on 6/5/24.
//

import Foundation

struct MoviesResponse: Decodable {
    let results: [Movie]
}

struct Movie: Decodable, Identifiable {
    let id: Int
    let backdropPath: String?
    let originalTitle, overview: String
    let popularity: Double
    let genreIDs: [Int]
    let posterPath: String?
    let releaseDate, title: String
    let voteAverage: Double

    enum CodingKeys: String, CodingKey {
        case id
        case backdropPath = "backdrop_path"
        case originalTitle = "original_title"
        case genreIDs = "genre_ids"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title
        case voteAverage = "vote_average"
    }
}

struct GenresResponse: Decodable {
    let genres: [Genre]
}

struct Genre: Decodable, Identifiable {
    let id: Int
    let name: String
}
