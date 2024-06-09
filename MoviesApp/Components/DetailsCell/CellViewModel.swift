//
//  CellViewModel.swift
//  MoviesApp
//
//  Created by Bakar Kharabadze on 6/9/24.
//

import Networking
import Foundation

class CellViewModel: ObservableObject {
    
    @Published var movies: [Movie] = []
    @Published var genres: [Genre] = []

      private let apiKey = "33a6e6cd1c269eeda4c9269cf6f55219"
      
      init() {
          fetchGenres()
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
    
    func posterURL(for path: String?) -> URL? {
        guard let path = path else { return nil }
        let baseURL = "https://image.tmdb.org/t/p/w500"
        return URL(string: baseURL + path)
    }
}
