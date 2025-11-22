//
//  APIClient.swift
//  Cricbuzz1
//
//  Created by ganesh shankar on 22/11/25.
//

import Foundation

final class APIClient {
    static let shared = APIClient()

    private init() {}

    private let apiKey = "YOUR_API_KEY"
    private let baseURL = "https://api.themoviedb.org/3"

    func request<T: Decodable>(_ endpoint: Endpoint) async throws -> T {
        guard var components = URLComponents(string: baseURL + endpoint.path) else { throw NetworkError.badURL }
        var query = endpoint.queryItems
        query.append(URLQueryItem(name: "api_key", value: apiKey))
        components.queryItems = query

        guard let url = components.url else { throw NetworkError.badURL }

        let (data, response) = try await URLSession.shared.data(from: url)

        guard let http = response as? HTTPURLResponse else { throw NetworkError.badResponse }

        if !(200...299).contains(http.statusCode) {
            throw NetworkError.serverError(http.statusCode)
        }

        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase

        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            throw NetworkError.decodingError
        }
    }
}
