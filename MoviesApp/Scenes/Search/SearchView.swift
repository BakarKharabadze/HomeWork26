//
//  SearchView.swift
//  MoviesApp
//
//  Created by Bakar Kharabadze on 6/5/24.
//

import SwiftUI

struct SearchView: View {
    @StateObject private var viewModel = SearchViewModel()
    @State private var query: String = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                TextField("Search for a movie...", text: $query)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .onChange(of: query) { newValue in
                        viewModel.searchMovies(query: newValue)
                    }
                
                if viewModel.isLoading {
                    Spacer()
                    ProgressView()
                        .padding()
                } else {
                    List(viewModel.movies) { movie in
                        MovieCell(movie: movie)
                    }
                    .listStyle(PlainListStyle())
                }
            }
            .navigationTitle("Search Movies")
        }
    }
}

#Preview {
    SearchView()
}
