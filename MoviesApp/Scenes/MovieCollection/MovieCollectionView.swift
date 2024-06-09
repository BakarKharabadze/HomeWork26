//
//  MovieCollectionView.swift
//  MoviesApp
//
//  Created by Bakar Kharabadze on 6/5/24.
//

import SwiftUI
import SwiftData

struct MovieCollectionView: View {
    @StateObject private var viewModel = MovieCollectionViewModel()
    private var columns = [GridItem(alignment: .top), GridItem(alignment: .top), GridItem(alignment: .top)]
    @Query private var favoriteMovies: [FavoriteMovie]
    
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                Text("Movies")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.horizontal)
                
                ScrollView {
                    LazyVGrid(columns: columns) {
                        ForEach(viewModel.movies) { movie in
                            NavigationLink(destination: MovieDetailsView(id: movie.id,
                                                                         title: movie.title,
                                                                         backdropPath: movie.backdropPath ?? "",
                                                                         voteAverage: movie.voteAverage,
                                                                         posterPath: movie.posterPath ?? "",
                                                                         releaseDate: movie.releaseDate,
                                                                         genreIDs: movie.genreIDs,
                                                                         overview: movie.overview)) {
                                MovieCell(movie: movie)
                                    .foregroundColor(.black)
                            }
                        }
                    }
                    .padding(.horizontal)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    MovieCollectionView()
}
