//
//  MovieResponse.swift
//  AppTest
//
//  Created by ganesh shankar on 22/11/25.
//

import Foundation

struct MovieResponse: Codable {
    let page: Int?
    let results: [Movie]
    let total_pages: Int?
    let total_results: Int?
}

struct Movie: Codable, Identifiable, Equatable {
    let id: Int
    let title: String
    let overview: String?
    let posterPath: String?
    let backdropPath: String?
    let voteAverage: Double?
    let releaseDate: String?
    let runtime: Int?
    let genres: [Genre]?

    var posterURL: URL? {
        guard let path = posterPath else { return nil }
        return URL(string: APIConfig.imageBaseURL + path)
    }

    var backdropURL: URL? {
        guard let path = backdropPath else { return nil }
        return URL(string: APIConfig.imageBaseURL + path)
    }
}

struct Genre: Codable, Identifiable, Equatable {
    let id: Int
    let name: String
}
