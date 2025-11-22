//
//  MoviesRepositoryProtocol.swift
//  Cricbuzz1
//
//  Created by ganesh shankar on 22/11/25.
//

import Foundation

protocol MoviesRepositoryProtocol {
    func getPopularMovies() async throws -> MoviesResponse
    func searchMovies(query: String) async throws -> MoviesResponse
    func getMovieDetail(id: Int) async throws -> MovieDetail
    func getVideos(id: Int) async throws -> VideosResponse
}

