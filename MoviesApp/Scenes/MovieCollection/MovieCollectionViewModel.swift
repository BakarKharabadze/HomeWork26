//
//  MovieCollectionViewModel.swift
//  MoviesApp
//
//  Created by Bakar Kharabadze on 6/5/24.
//

import Foundation
import Networking

final class MovieCollectionViewModel: ObservableObject {
    
    @Published var movies: [Movie] = []
    
    init() {
        fetchMovies()
    }
    
    private func fetchMovies() {
        let url = "https://api.themoviedb.org/3/movie/popular?api_key=33a6e6cd1c269eeda4c9269cf6f55219"
        NetworkManager.shared.request(url: url) { [weak self] (result: Result<MoviesResponse, NetworkError>) in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    self?.movies = response.results
                case .failure(let error):
                    print("Failed to fetch: \(error)")
                }
            }
        }
    }
}
