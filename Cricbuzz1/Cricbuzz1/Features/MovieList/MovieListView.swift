//
//  MovieListView.swift
//  Cricbuzz1
//
//  Created by ganesh shankar on 22/11/25.
//

import SwiftUI

struct MovieListView: View {
    @StateObject private var vm = MovieListViewModel()
    @StateObject private var favorites = FavoritesStore()

    var body: some View {
        NavigationView {
            VStack {
                searchBar
                content
            }
            .navigationTitle("Movies")
        }
        .environmentObject(favorites)
        .task {
            await vm.loadPopularMovies()
        }
    }

    private var searchBar: some View {
        TextField("Search...", text: $vm.searchText)
            .textFieldStyle(.roundedBorder)
            .padding()
            .onChange(of: vm.searchText) { _ in
                Task { await vm.search() }
            }
    }

    @ViewBuilder
    private var content: some View {
        if vm.isLoading {
            ProgressView().padding()
        } else {
            List(vm.movies) { movie in
                NavigationLink {
                    MovieDetailView(movieId: movie.id)
                } label: {
                    MovieRowView(movie: movie)
                }
            }
            .listStyle(.plain)
        }
    }
}

#Preview {
    MovieListView()
}
