//
//  MainTabView.swift
//  MoviesApp
//
//  Created by Bakar Kharabadze on 6/5/24.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            MovieCollectionView()
                .tabItem {
                    Image("Home")
                        .renderingMode(.template)
                    Text("Home")
                }
            SearchView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Search")
                }
            FavoritesView()
                .tabItem {
                    Image("Favorites")
                        .renderingMode(.template)
                    Text("Favorites")
                }
        }
        .accentColor(.blue)
    }
}

#Preview {
    MainTabView()
}
