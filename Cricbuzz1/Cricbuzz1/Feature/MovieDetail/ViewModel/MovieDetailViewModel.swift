//
//  MovieDetailViewModel.swift
//  AppTest
//
//  Created by ganesh shankar on 22/11/25.
//

import Foundation
import Combine

@MainActor
class MovieDetailViewModel: ObservableObject {
    @Published var detail: MovieDetail?
    @Published var videos: [Video] = []
    @Published var isLoading = false

    let movieId: Int
    let service: MovieServiceProtocol

    /// Returns the first YouTube trailer key
    var trailerKey: String? {
        videos.first(where: { ($0.type ?? "").lowercased() == "trailer" })?.key
    }

    init(movieId: Int, service: MovieServiceProtocol) {
        self.movieId = movieId
        self.service = service
    }

    /// Loads movie detail + videos together
    func load() async {
        isLoading = true

        async let detailCall = service.fetchMovieDetail(id: movieId)
        async let videoCall = service.fetchMovieVideos(id: movieId) 

        do {
            self.detail = try await detailCall
            self.videos = try await videoCall
        } catch {
            print("❌ Error loading movie detail:", error)
        }

        isLoading = false
    }
}

