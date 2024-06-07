//
//  MovieCell.swift
//  MoviesApp
//
//  Created by Bakar Kharabadze on 6/6/24.
//

import SwiftUI

struct MovieCell: View {
    
    private var viewModel = MovieCellViewModel()
    
    var movie: Movie
    
    public init(movie: Movie) {
        self.movie = movie
    }
    
    var body: some View {
        VStack {
            if let posterURL = viewModel.posterURL(for: movie.posterPath) {
                AsyncImage(url: posterURL) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 100, height: 150)
                        .cornerRadius(8)
                } placeholder: {
                    ProgressView()
                        .frame(width: 100, height: 150)
                }
            }
            Text(movie.title)
                .font(.title3)
                .lineLimit(2)
                .foregroundColor(.primary)
        }
        .padding(.vertical, 8)
    }
}

