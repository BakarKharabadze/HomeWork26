////  FavoritesManager.swift
////  MoviesApp
////
////  Created by Bakar Kharabadze on 6/9/24.
////
//
//import Foundation
//
//
//class FavoritesViewModel: ObservableObject  {
//    
//    @Published var favorites = [Movie]()
//    
//    static let shared = FavoritesViewModel()
//    private let favoritesKey = "favorites"
//    
//    init() {
//    }
//    
//    func addFavorite(movie: Movie) {
//        var favorites = getFavorites()
//        if !favorites.contains(where: { $0.id == movie.id }) {
//            favorites.append(movie)
//            saveFavorites(favorites)
//        }
//    }
//    
//    func removeFavorite(movie: Movie) {
//        var favorites = getFavorites()
//        favorites.removeAll(where: { $0.id == movie.id })
//        saveFavorites(favorites)
//    }
//    
//    func getFavorites() -> [Movie] {
//        if let data = UserDefaults.standard.data(forKey: favoritesKey) {
//            let decoder = JSONDecoder()
//            if let favorites = try? decoder.decode([Movie].self, from: data) {
//                return favorites
//            }
//        }
//        return []
//    }
//    
//    func saveFavorites(_ favorites: [Movie]) {
//        let encoder = JSONEncoder()
//        if let data = try? encoder.encode(favorites) {
//            UserDefaults.standard.set(data, forKey: favoritesKey)
//        }
//    }
//    
//    func isFavorite(movie: Movie) -> Bool {
//        return getFavorites().contains(where: { $0.id == movie.id })
//    }
//}
