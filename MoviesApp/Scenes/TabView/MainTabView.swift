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
        }
        .accentColor(.blue)
    }
}

#Preview {
    MainTabView()
}
