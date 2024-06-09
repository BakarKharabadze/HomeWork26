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
    @Published var genres: [Genre] = []
    @Published var currentlySelectedSearchFilter: SelectedSearchFilter = .name

    
    private let apiKey = "33a6e6cd1c269eeda4c9269cf6f55219"
    private let baseUrl = "https://api.themoviedb.org"
    private let discoverPath = "/3/discover/movie"
    private let searchPath = "/3/search/movie"
    private let genrePath = "/3/genre/movie/list"
    
    func searchMovies(text: String, completion: @escaping ([Movie]) -> Void) {
        guard !text.isEmpty else { return }
        
        isLoading = true
        var requestUrl = ""
        
        switch currentlySelectedSearchFilter {
        case .name:
            requestUrl = baseUrl + searchPath +
            "?api_key=\(apiKey)&query=\(text.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")"
            
        case .year:
            requestUrl = baseUrl + discoverPath + "?api_key=\(apiKey)&primary_release_year=\(text)"
            
        case .genre:
            if let genre = genres.first(where: { $0.name.lowercased() == text.lowercased() }) {
                requestUrl = baseUrl + discoverPath + "?api_key=\(apiKey)&with_genres=\(genre.id)"
            } else {
                DispatchQueue.main.async {
                    self.isLoading = false
                    completion([])
                }
                return
            }
        }
        
        NetworkManager.shared.request(url: requestUrl) { [weak self] (result: Result<MoviesResponse, NetworkError>) in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let response):
                    self?.movies = response.results
                    completion(response.results)
                case .failure(let error):
                    print("Failed to load movies: \(error)")
                    completion([])
                }
            }
        }
    }
    
    func performSearch(query: String, completion: @escaping (Bool) -> Void) {
        switch currentlySelectedSearchFilter {
        case .name:
            if query.isEmpty || Int(query) != nil {
                completion(true)
            } else {
                searchMovies(text: query) { movies in
                    completion(movies.isEmpty)
                }
            }
        case .year:
            if let year = Int(query), year > 1800, year < 2025 {
                searchMovies(text: query) { movies in
                    completion(movies.isEmpty)
                }
            } else {
                completion(true)
            }
        case .genre:
            if query.isEmpty || Int(query) != nil {
                completion(true)
            } else {
                searchMovies(text: query) { movies in
                    completion(movies.isEmpty)
                }
            }
        }
    }
}

enum SelectedSearchFilter {
    case name
    case year
    case genre
}

