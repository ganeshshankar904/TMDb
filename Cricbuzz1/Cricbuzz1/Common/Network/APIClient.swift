//
//  APIClient.swift
//  Cricbuzz1
//
//  Created by ganesh shankar on 22/11/25.
//

import Foundation
enum APIConfig {
    static let apiKey = "7dc44631adf5a74a2a9b71d2615d29a5" 
    static let baseURL = "https://api.themoviedb.org/3"
    static let imageBaseURL = "https://image.tmdb.org/t/p/w500"
}

import Foundation

final class APIClient {

    static let shared = APIClient()

    private let decoder: JSONDecoder = {
        let d = JSONDecoder()
        d.keyDecodingStrategy = .convertFromSnakeCase
        return d
    }()
    
    // MARK: Popular Movies
    func fetchPopularMovies() async throws -> MovieResponse {
        let url = URL(string: "\(APIConfig.baseURL)/movie/popular?api_key=\(APIConfig.apiKey)")!
        let (data, _) = try await URLSession.shared.data(from: url)
        return try decoder.decode(MovieResponse.self, from: data)
    }

    // MARK: Movie Details
    func fetchMovieDetail(id: Int) async throws -> MovieDetail {
        let url = URL(string: "\(APIConfig.baseURL)/movie/\(id)?api_key=\(APIConfig.apiKey)")!
        let (data, _) = try await URLSession.shared.data(from: url)
        return try decoder.decode(MovieDetail.self, from: data)
    }

    // MARK: Trailers
    func fetchMovieVideos(id: Int) async throws -> VideoResponse {
        let url = URL(string: "\(APIConfig.baseURL)/movie/\(id)/videos?api_key=\(APIConfig.apiKey)")!
        let (data, _) = try await URLSession.shared.data(from: url)
        return try decoder.decode(VideoResponse.self, from: data)
    }

    // MARK: Search Movies
    func searchMovies(query: String) async throws -> MovieResponse {
        let encoded = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? query
        let url = URL(string: "\(APIConfig.baseURL)/search/movie?api_key=\(APIConfig.apiKey)&query=\(encoded)")!
        let (data, _) = try await URLSession.shared.data(from: url)
        return try decoder.decode(MovieResponse.self, from: data)
    }
}

