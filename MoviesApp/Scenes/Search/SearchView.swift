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
    @State private var showNoResultsMessage = false
    
    var body: some View {
        NavigationStack {
            VStack {
                searchBar
                content
            }
            .navigationTitle("Search")
        }
    }
    
    //MARK: - Search Bar
    private var searchBar: some View {
        HStack {
            ZStack(alignment: .trailing) {
                TextField("Search for a movie...", text: $query)
                    .padding(EdgeInsets(top: 12, leading: 20, bottom: 12, trailing: 50))
                    .background(Color("TextFieldColor"))
                    .cornerRadius(16)
                    .overlay(
                        HStack {
                            Spacer()
                            Button(action: {
                                viewModel.performSearch(query: query) { noResults in
                                    showNoResultsMessage = noResults
                                }
                            }) {
                                Image("Search")
                                    .renderingMode(.template)
                                    .foregroundColor(.primary)
                                    .padding(.trailing, 15)
                            }
                        }
                    )
                    .padding(.leading, 20)
                    .padding(.trailing, 60)
                
                searchFilterMenu
            }
        }
    }
    
    //MARK: - Menu
    private var searchFilterMenu: some View {
        Menu {
            Button(action: {
                viewModel.currentlySelectedSearchFilter = .name
            }) {
                HStack {
                    Text("Name")
                    if viewModel.currentlySelectedSearchFilter == .name {
                        Spacer()
                        Image(systemName: "checkmark")
                    }
                }
            }
            Button(action: {
                viewModel.currentlySelectedSearchFilter = .year
            }) {
                HStack {
                    Text("Year")
                    if viewModel.currentlySelectedSearchFilter == .year {
                        Spacer()
                        Image(systemName: "checkmark")
                    }
                }
            }
            Button(action: {
                viewModel.currentlySelectedSearchFilter = .genre
            }) {
                HStack {
                    Text("Genre")
                    if viewModel.currentlySelectedSearchFilter == .genre {
                        Spacer()
                        Image(systemName: "checkmark")
                    }
                }
            }
        } label: {
            Image(systemName: "ellipsis.circle")
                .foregroundColor(.primary)
                .font(.title)
                .padding(.trailing, 15)
        }
    }
    
    private var content: some View {
        Group {
            if viewModel.isLoading {
                Spacer()
                ProgressView()
                    .padding()
            } else if showNoResultsMessage {
                Spacer()
                noResultsView
                Spacer()
            } else {
                movieListView
            }
        }
    }
    
    //MARK: - Error showing
    private var noResultsView: some View {
        VStack {
            Text("Oh No Isn’t This So Embarrassing?")
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundColor(.gray)
            Text("I cannot find any movie with this name.")
                .font(.subheadline)
                .foregroundColor(.gray)
        }
    }
    
    private var movieListView: some View {
        List(viewModel.movies) { movie in
            NavigationLink(destination: MovieDetailsView(id: movie.id,
                                                         title: movie.title,
                                                         backdropPath: movie.backdropPath ?? "",
                                                         voteAverage: movie.voteAverage,
                                                         posterPath: movie.posterPath ?? "",
                                                         releaseDate: movie.releaseDate,
                                                         genreIDs: movie.genreIDs,
                                                         overview: movie.overview)) {
                MovieDetailsCell(title: movie.title,
                                 voteAverage: movie.voteAverage,
                                 posterPath: movie.posterPath ?? "",
                                 releaseDate: movie.releaseDate,
                                 genreIDs: movie.genreIDs)
                .foregroundColor(.black)
            }
        }
        .listStyle(PlainListStyle())
    }
}

#Preview {
    SearchView()
}
