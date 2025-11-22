//
//  MovieListViewModel.swift
//  Cricbuzz1
//
//  Created by ganesh shankar on 22/11/25.
//

import Foundation
import Combine
import Foundation

@MainActor
final class MovieListViewModel: ObservableObject {

    @Published var movies: [Movie] = []
    @Published var searchText = ""
    @Published var isLoading = false

    func loadPopularMovies() async {
        isLoading = true
        do {
            let response = try await APIClient.shared.fetchPopularMovies()
            movies = response.results
        } catch {
            print("Error:", error)
        }
        isLoading = false
    }

    func search() async {
        guard !searchText.isEmpty else {
            await loadPopularMovies()
            return
        }

        isLoading = true
        do {
            let response = try await APIClient.shared.searchMovies(query: searchText)
            movies = response.results
        } catch {
            print("Search error:", error)
        }
        isLoading = false
    }
}
