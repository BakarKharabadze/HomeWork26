//
//  MovieCollectionView.swift
//  MoviesApp
//
//  Created by Bakar Kharabadze on 6/5/24.
//

import SwiftUI

struct MovieCollectionView: View {
    @StateObject private var viewModel = MovieCollectionViewModel()
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.movies) { movie in
                   MovieCell(movie: movie)
                }
            }
            .navigationTitle("Movies")
        }
    }
        
}
    


#Preview {
    MovieCollectionView()
}
