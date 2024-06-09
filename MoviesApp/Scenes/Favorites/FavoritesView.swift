//
//  FavoritesView.swift
//  MoviesApp
//
//  Created by Bakar Kharabadze on 6/9/24.
//

import SwiftUI

struct FavoritesView: View {
    @StateObject var viewModel = FavoritesViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                if viewModel.favorites.isEmpty {
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
            .onAppear {
                loadFavorites()
            }
        }
    }
    
    private var movieListView: some View {
        List(viewModel.favorites) { movie in
            NavigationLink(destination: MovieDetailsView(movie: movie)) {
                MovieDetailsCell(movie: movie)
                    .foregroundColor(.black)
            }
        }
        .listStyle(PlainListStyle())
    }
    
    private func loadFavorites() {
        viewModel.favorites = FavoritesViewModel.shared.getFavorites()
    }
}

#Preview {
    FavoritesView()
}
