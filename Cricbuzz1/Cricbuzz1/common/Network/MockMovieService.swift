//
//  MockMovieService.swift
//  AppTest
//
//  Created by ganesh shankar on 22/11/25.
//

import Foundation

final class MockMovieService: MovieServiceProtocol {
    var mockMovies: [Movie] = []
    var mockDetail: MovieDetail?
    var mockVideos: [Video] = []
    var shouldThrow = false

    func fetchPopularMovies() async throws -> [Movie] {
        if shouldThrow { throw URLError(.badServerResponse) }
        return mockMovies
    }

    func searchMovies(query: String) async throws -> [Movie] {
        if shouldThrow { throw URLError(.badServerResponse) }
        return mockMovies
    }

    func fetchMovieDetail(id: Int) async throws -> MovieDetail {
        if shouldThrow { throw URLError(.badServerResponse) }
        if let d = mockDetail { return d }
        throw URLError(.fileDoesNotExist)
    }

    func fetchMovieVideos(id: Int) async throws -> [Video] {
        if shouldThrow { throw URLError(.badServerResponse) }
        return mockVideos
    }
}

