//
//  MovieServiceProtocol.swift
//  AppTest
//
//  Created by ganesh shankar on 22/11/25.
//

import Foundation

protocol MovieServiceProtocol {
    func fetchPopularMovies() async throws -> [Movie]
    func searchMovies(query: String) async throws -> [Movie]
    func fetchMovieDetail(id: Int) async throws -> MovieDetail
    func fetchMovieVideos(id: Int) async throws -> [Video]
}

