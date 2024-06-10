//
//  MovieDetailsViewModel.swift
//  MoviesApp
//
//  Created by Bakar Kharabadze on 6/7/24.
//

import Networking
import Foundation
import SwiftData

final class MovieDetailsViewModel: ObservableObject {
    
    @Published var movies: [Movie] = []
    @Published var genres: [Genre] = []
    @Published var isFavorite = false

    private let apiKey = "33a6e6cd1c269eeda4c9269cf6f55219"
    
    init() {
        fetchGenres()
    }
    
    func posterURL(for path: String?) -> URL? {
        guard let path = path else { return nil }
        let baseURL = "https://image.tmdb.org/t/p/w500"
        return URL(string: baseURL + path)
    }
    
    func backDropURL(for path: String?) -> URL? {
        guard let path = path else { return nil }
        let baseURL = "https://image.tmdb.org/t/p/w500"
        return URL(string: baseURL + path)
    }
    
    func fetchGenres() {
        let url = "https://api.themoviedb.org/3/genre/movie/list?api_key=\(apiKey)&language=en"
        NetworkManager.shared.request(url: url) { [weak self] (result: Result<GenresResponse, NetworkError>) in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    self?.genres = response.genres
                case .failure(let error):
                    print("Failed to fetch genres: \(error)")
                }
            }
        }
    }
    
    func fetchMoviesByGenre(genreId: Int) {
        let url = "https://api.themoviedb.org/3/discover/movie?api_key=\(apiKey)&with_genres=\(genreId)"
        NetworkManager.shared.request(url: url) { [weak self] (result: Result<MoviesResponse, NetworkError>) in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    self?.movies = response.results
                case .failure(let error):
                    print("Failed to fetch movies by genre: \(error)")
                }
            }
        }
    }
    
    func checkIfFavorite(favoriteMovies: [FavoriteMovie], movieID: Int) {
        isFavorite = favoriteMovies.contains { $0.id == movieID }
    }
    
    func toggleFavorite(favoriteMovies: [FavoriteMovie], modelContext: ModelContext, movie: FavoriteMovie) {
        if isFavorite {
            if let favoriteMovie = favoriteMovies.first(where: { $0.id == movie.id }) {
                modelContext.delete(favoriteMovie)
            }
        } else {
            modelContext.insert(movie)
        }
        isFavorite.toggle()
    }
}
