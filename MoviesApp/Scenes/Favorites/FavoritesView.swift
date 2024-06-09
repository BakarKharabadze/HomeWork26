//
//  FavoritesView.swift
//  MoviesApp
//
//  Created by Bakar Kharabadze on 6/9/24.
//
import SwiftUI
import SwiftData

struct FavoritesView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var favoriteMovies: [FavoriteMovie]

    var body: some View {
        NavigationStack {
            VStack {
                if favoriteMovies.isEmpty {
                    VStack {
                        Spacer()
                        VStack {
                            Text("No Favourites Yet")
                                .font(.title)
                                .fontWeight(.semibold)
                            
                            Text("All moves marked as favourite will be added here")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        Spacer()
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    movieListView
                }
            }
            .navigationTitle("Favorites")
        }
    }
    
    private var movieListView: some View {
        List(favoriteMovies) { favoriteMovie in
            NavigationLink(destination: MovieDetailsView(id: favoriteMovie.id, title: favoriteMovie.title, backdropPath: favoriteMovie.backdropPath ?? "", voteAverage: favoriteMovie.voteAverage, posterPath: favoriteMovie.posterPath ?? "", releaseDate: favoriteMovie.releaseDate, genreIDs: favoriteMovie.genreIDs, overview: favoriteMovie.overview)) {
                MovieDetailsCell(title: favoriteMovie.title, voteAverage: favoriteMovie.voteAverage, posterPath: favoriteMovie.posterPath ?? "", releaseDate: favoriteMovie.releaseDate, genreIDs: favoriteMovie.genreIDs)
                    .foregroundColor(.black)
            }
        }
        .listStyle(PlainListStyle())
    }
}


