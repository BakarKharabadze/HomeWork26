//
//  MovieCellViewModel.swift
//  MoviesApp
//
//  Created by Bakar Kharabadze on 6/6/24.
//

import Foundation

final class MovieCellViewModel {
    
    func posterURL(for path: String?) -> URL? {
        guard let path = path else { return nil }
        let baseURL = "https://image.tmdb.org/t/p/w500"
        return URL(string: baseURL + path)
    }
    
}
