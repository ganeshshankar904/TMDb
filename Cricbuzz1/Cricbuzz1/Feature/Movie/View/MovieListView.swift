//
//  MovieListView.swift
//  AppTest
//
//  Created by ganesh shankar on 23/11/25.
//

import SwiftUI

struct MovieListView: View {
    @EnvironmentObject var router: Router
    @EnvironmentObject var favorites: FavoritesStore
    @StateObject private var vm = MovieListViewModel()

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                TextField("Search movies...", text: $vm.searchText)
                    .textFieldStyle(.roundedBorder)
                    .padding(.horizontal)
                    .onSubmit {
                        Task { await vm.search() }
                    }
                    .onChange(of: vm.searchText) { _ in
                        Task { await vm.search() }
                    }
            }
            .padding(.top)

            content
        }
        .navigationTitle("Popular Movies")
        .navigationBarBackButtonHidden(true)
        .task {
            print("Poster Path →", vm.movies.first?.posterPath as Any)
            print("Poster URL:",  vm.movies.first?.posterURL as Any)
            await vm.loadPopular() }
    }

    @ViewBuilder
    private var content: some View {
        if vm.isLoading {
            ProgressView()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        } else if vm.movies.isEmpty {
            VStack {
                Text("No movies found")
                    .foregroundColor(.secondary)
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        } else {
            List(vm.movies) { movie in
                Button {
                    router.navigate(to: .movieDetail(id: movie.id))
                } label: {
                    MovieRowView(movie: movie)
                }
                .buttonStyle(.plain)
            }
            .listStyle(.plain)
        }
    }
}
