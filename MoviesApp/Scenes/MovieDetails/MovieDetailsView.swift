//
//  MovieDetailsView.swift
//  MoviesApp
//
//  Created by Bakar Kharabadze on 6/7/24.
//

import SwiftUI

struct MovieDetailsView: View {
    
    @StateObject var viewModel = MovieDetailsViewModel()
    var movie: Movie
    @State private var isFavorite = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    backdropImage
                    movieInfo
                    movieDetails
                }
            }
            .navigationTitle(movie.title)
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                viewModel.fetchGenres()
                isFavorite = FavoritesViewModel.shared.isFavorite(movie: movie)
            }
        }
    }
    
    private var backdropImage: some View {
        ZStack {
            if let backDropUrl = viewModel.backDropURL(for: movie.backdropPath) {
                AsyncImage(url: backDropUrl) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 400, height: 210)
                        .cornerRadius(16)
                } placeholder: {
                    ProgressView()
                        .frame(width: 400, height: 210)
                }
                
                HStack {
                    Image(systemName: "star.fill")
                        .foregroundColor(.orange)
                    Text(String(format: "%.1f", movie.voteAverage))
                        .foregroundColor(.orange)
                }
                .padding(8)
                .background(Color("RatingColor"))
                .cornerRadius(10)
                .padding(.leading, 8)
                .padding(.bottom, 8)
                .offset(x: 140, y: 80)
            }
        }
    }
    
    private var movieInfo: some View {
        VStack {
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
                            .frame(width: 95, height: 120)
                    }
                }
                VStack {
                    Spacer()
                    Text(movie.title)
                        .font(.subheadline)
                        .fontWeight(.bold)
                        .lineLimit(2)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom)
            }
            .padding(.leading, 25)
        }
        .padding(.top, -80)
    }
    
    private var movieDetails: some View {
        VStack {
            movieMetadata
            aboutMovie
        }
    }
    
    private var movieMetadata: some View {
        HStack {
            Image("Calendar")
            Text(movie.releaseDate)
                .font(.footnote)
                .foregroundStyle(.secondary)
            Divider()
                .overlay(Color.primary)
            Image("Ticket")
            ForEach(viewModel.genres.filter { movie.genreIDs.contains($0.id) }) { genre in
                Text("\(genre.name).")
                    .font(.footnote)
                    .foregroundStyle(.secondary)
            }
        }
        .padding(.top, 8)
    }
    
    private var aboutMovie: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("About Movie")
                    .font(.headline)
                    .padding(.top, 16)
                    .padding(.horizontal, 40)
                Spacer()
                HStack {
                    Button(action: {
                        toggleFavorite()
                    }) {
                        Image(systemName: isFavorite ? "heart.fill" : "heart")
                            .foregroundColor(isFavorite ? .red : .black)
                    }
                }.padding(.leading, -60)
                    .padding(.bottom, -20)
            }
            Divider()
                .frame(width: 335, height: 4)
                .background(.gray)
                .cornerRadius(2)
                .padding(.horizontal)
                .padding(.top, 5)
                .padding(.bottom, 20)
                .frame(maxWidth: .infinity, alignment: .center)
            
            Text(movie.overview)
                .padding(.horizontal, 40)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private func toggleFavorite() {
        if isFavorite {
            FavoritesViewModel.shared.removeFavorite(movie: movie)
        } else {
            FavoritesViewModel.shared.addFavorite(movie: movie)
        }
        isFavorite.toggle()
    }
}

