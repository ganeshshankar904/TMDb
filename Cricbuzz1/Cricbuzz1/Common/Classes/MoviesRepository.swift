//
//  MoviesRepository.swift
//  Cricbuzz1
//
//  Created by ganesh shankar on 22/11/25.
//

import Foundation

final class MoviesRepository: MoviesRepositoryProtocol {
    private let api = APIClient.shared

    func getPopularMovies() async throws -> MoviesResponse {
        try await api.request(.popular)
    }

    func searchMovies(query: String) async throws -> MoviesResponse {
        try await api.request(.search(query: query))
    }

    func getMovieDetail(id: Int) async throws -> MovieDetail {
        try await api.request(.detail(id: id))
    }

    func getVideos(id: Int) async throws -> VideosResponse {
        try await api.request(.videos(id: id))
    }
}

