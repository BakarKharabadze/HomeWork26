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
        HStack(alignment: .top) {
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
            VStack(alignment: .leading, spacing: 8) {
                Text(movie.title)
                    .font(.headline)
                    .lineLimit(2)
                Text(movie.releaseDate)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                Spacer()
                HStack {
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                        .padding(-5)
                    Text(String(format: "%.1f", movie.voteAverage))
                        .foregroundColor(.yellow)
                }
            }
            .padding(.leading, 8)
        }
        .padding(.vertical, 8)
    }
}


