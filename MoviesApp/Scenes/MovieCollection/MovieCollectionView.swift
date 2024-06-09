//
//  MovieCollectionView.swift
//  MoviesApp
//
//  Created by Bakar Kharabadze on 6/5/24.
//

import SwiftUI

struct MovieCollectionView: View {
    @StateObject private var viewModel = MovieCollectionViewModel()
    private var columns = [GridItem(alignment: .top), GridItem(alignment: .top), GridItem(alignment: .top)]
    
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
                            NavigationLink(destination: MovieDetailsView(movie: movie)) {
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
