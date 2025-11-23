//
//  MovieListViewModel.swift
//  AppTest
//
//  Created by ganesh shankar on 22/11/25.
//

import Foundation
import Combine
@MainActor
final class MovieListViewModel: ObservableObject {
    @Published var movies: [Movie] = []
    @Published var searchText: String = ""
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let service: MovieServiceProtocol

    init(service: MovieServiceProtocol = TMDbService()) {
        self.service = service
    }

    func loadPopular() async {
        isLoading = true
        errorMessage = nil
        defer { isLoading = false }
        do {
            let results = try await service.fetchPopularMovies()
            self.movies = results
        } catch {
            self.movies = []
            self.errorMessage = error.localizedDescription
        }
    }

    func search() async {
        let q = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        if q.isEmpty {
            await loadPopular()
            return
        }
        isLoading = true
        errorMessage = nil
        defer { isLoading = false }
        do {
            let results = try await service.searchMovies(query: q)
            self.movies = results
        } catch {
            self.movies = []
            self.errorMessage = error.localizedDescription
        }
    }
}

