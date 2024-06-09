//
//  MovieDetailsCell.swift
//  MoviesApp
//
//  Created by Bakar Kharabadze on 6/9/24.
//

import SwiftUI

struct MovieDetailsCell: View {
    
    @StateObject var viewModel = CellViewModel()
    
   
    var title: String
    var voteAverage: Double
    var posterPath: String
    var releaseDate: String
    var genreIDs: [Int]
    
    
    var body: some View {
        HStack {
            if let posterURL = viewModel.posterURL(for: posterPath) {
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
                Text(title)
                    .foregroundColor(.primary)
                    .font(.headline)
                    .lineLimit(2)
                    .padding(.bottom, 6)
                
                HStack {
                    Image(systemName: "star")
                        .foregroundColor(.orange)
                    Text(String(format: "%.1f", voteAverage))
                        .foregroundColor(.orange)
                        .padding(.horizontal, -5)
                }
                HStack {
                    Image("Ticket")
                        .renderingMode(.template)
                        .foregroundColor(.primary)
                    if let firstGenre = viewModel.genres.first(where: { genreIDs.contains($0.id) }) {
                        Text(firstGenre.name)
                            .font(.footnote)
                            .foregroundColor(.primary)
                    }
                }
                HStack {
                    Image("Calendar")
                        .renderingMode(.template)
                        .foregroundColor(.primary)
                    Text(releaseDate)
                        .font(.footnote)
                        .foregroundColor(.primary)
                }
            }
            .padding(.leading, 8)
        }
        .padding(.vertical, 4)
    }
}
