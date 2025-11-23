//
//  TMDbService.swift
//  AppTest
//
//  Created by ganesh shankar on 22/11/25.
//
import Foundation

final class TMDbService: MovieServiceProtocol {
    private let decoder: JSONDecoder = {
        let d = JSONDecoder()
        d.keyDecodingStrategy = .convertFromSnakeCase
        return d
    }()

    private func validate(_ response: URLResponse) throws {
        if let http = response as? HTTPURLResponse {
            guard (200...299).contains(http.statusCode) else {
                throw URLError(.badServerResponse)
            }
        }
    }

    func fetchPopularMovies() async throws -> [Movie] {
        guard var comp = URLComponents(string: APIConfig.baseURL + "/movie/popular") else { throw URLError(.badURL) }
        comp.queryItems = [URLQueryItem(name: "api_key", value: APIConfig.apiKey)]
        let url = comp.url!
        let (data, response) = try await URLSession.shared.data(from: url)
        try validate(response)
        let decoded = try decoder.decode(MovieResponse.self, from: data)
        return decoded.results
    }

    func searchMovies(query: String) async throws -> [Movie] {
        guard var comp = URLComponents(string: APIConfig.baseURL + "/search/movie") else { throw URLError(.badURL) }
        comp.queryItems = [URLQueryItem(name: "api_key", value: APIConfig.apiKey),
                           URLQueryItem(name: "query", value: query)]
        let url = comp.url!
        let (data, response) = try await URLSession.shared.data(from: url)
        try validate(response)
        let decoded = try decoder.decode(MovieResponse.self, from: data)
        return decoded.results
    }

    func fetchMovieDetail(id: Int) async throws -> MovieDetail {
        guard var comp = URLComponents(string: APIConfig.baseURL + "/movie/\(id)") else { throw URLError(.badURL) }
        // append credits and videos for convenience
        comp.queryItems = [URLQueryItem(name: "api_key", value: APIConfig.apiKey),
                           URLQueryItem(name: "append_to_response", value: "credits,videos")]
        let url = comp.url!
        let (data, response) = try await URLSession.shared.data(from: url)
        try validate(response)
        let decoded = try decoder.decode(MovieDetail.self, from: data)
        return decoded
    }

    func fetchMovieVideos(id: Int) async throws -> [Video] {
        guard var comp = URLComponents(string: APIConfig.baseURL + "/movie/\(id)/videos") else { throw URLError(.badURL) }
        comp.queryItems = [URLQueryItem(name: "api_key", value: APIConfig.apiKey)]
        let url = comp.url!
        let (data, response) = try await URLSession.shared.data(from: url)
        try validate(response)
        let decoded = try decoder.decode(VideoResponse.self, from: data)
        return decoded.results
    }
}
