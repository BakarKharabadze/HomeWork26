//
//  MovieDetailsCell.swift
//  MoviesApp
//
//  Created by Bakar Kharabadze on 6/9/24.
//

import SwiftUI

struct MovieDetailsCell: View {
    
    @StateObject var viewModel = CellViewModel()
    var movie: Movie
    
    public init(movie: Movie) {
        self.movie = movie
    }
    
    var body: some View {
        HStack {
            if let posterURL = viewModel.posterURL(for: movie.posterPath) {
                AsyncImage(url: posterURL) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 95, height: 120)
                        .cornerRadius(16)
                } placeholder: {
                    ProgressView()
                        .frame(width: 100, height: 150)
                }
            }
            VStack(alignment: .leading) {
                Text(movie.title)
                    .foregroundColor(.primary)
                    .font(.headline)
                    .lineLimit(2)
                    .padding(.bottom, 6)
                
                HStack {
                    Image(systemName: "star")
                        .foregroundColor(.orange)
                    Text(String(format: "%.1f", movie.voteAverage))
                        .foregroundColor(.orange)
                        .padding(.horizontal, -5)
                }
                HStack {
                    Image("Ticket")
                        .renderingMode(.template)
                        .foregroundColor(.primary)
                    if let firstGenre = viewModel.genres.first(where: { movie.genreIDs.contains($0.id) }) {
                        Text(firstGenre.name)
                            .font(.footnote)
                            .foregroundColor(.primary)
                    }
                }
                HStack {
                    Image("Calendar")
                        .renderingMode(.template)
                        .foregroundColor(.primary)
                    Text(movie.releaseDate)
                        .font(.footnote)
                        .foregroundColor(.primary)
                }
            }
            .padding(.leading, 8)
        }
        .padding(.vertical, 4)
    }
}
