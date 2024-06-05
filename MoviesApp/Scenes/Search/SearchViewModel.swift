//
//  SearchViewModel.swift
//  MoviesApp
//
//  Created by Bakar Kharabadze on 6/5/24.
//

import Foundation
import Networking

final class SearchViewModel: ObservableObject {
    
    @Published var movies: [Movie] = []
    @Published var isLoading = false
    
    func searchMovies(query: String) {
        guard !query.isEmpty else { return }
        
        isLoading = true
        let urlString = "https://api.themoviedb.org/3/search/movie?api_key=33a6e6cd1c269eeda4c9269cf6f55219&query=\(query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")"
        
        NetworkManager.shared.request(url: urlString) { [weak self] (result: Result<MoviesResponse, NetworkError>) in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let response):
                    self?.movies = response.results
                case .failure(let error):
                    print("Failed: \(error)")
                }
            }
        }
    }
}
