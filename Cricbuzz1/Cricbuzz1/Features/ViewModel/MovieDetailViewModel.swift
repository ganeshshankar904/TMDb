//
//  MovieDetailViewModel.swift
//  Cricbuzz1
//
//  Created by ganesh shankar on 22/11/25.
//
import Foundation
import Combine
@MainActor
final class MovieDetailViewModel: ObservableObject {

    @Published var movie: MovieDetail?
    @Published var trailers: [Video] = []

    func load(id: Int) async {
        do {
            movie = try await APIClient.shared.fetchMovieDetail(id: id)
            let result = try await APIClient.shared.fetchMovieVideos(id: id)
            trailers = result.results.filter { $0.site == "YouTube" }
        } catch {
            print("Detail Error:", error)
        }
    }
}


