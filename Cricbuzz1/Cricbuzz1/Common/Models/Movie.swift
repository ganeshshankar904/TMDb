//
//  Movie.swift
//  Cricbuzz1
//
//  Created by ganesh shankar on 22/11/25.
//

import Foundation


struct MovieResponse: Codable {
    let results: [Movie]
}

struct Movie: Identifiable, Codable {
    let id: Int
    let title: String
    let overview: String?
    let posterPath: String?
    let voteAverage: Double
    let runtime: Int?
}

struct MovieDetail: Codable, Identifiable {
    let id: Int
    let title: String
    let overview: String
    let genres: [Genre]
    let runtime: Int?
    let voteAverage: Double
}

struct Genre: Codable {
    let id: Int
    let name: String
}

// MARK: - Credits
struct CreditsResponse: Codable {
    let cast: [CastMember]
    let crew: [CrewMember]?
}

struct CastMember: Codable, Identifiable {
    let id: Int
    let name: String
    let character: String?
    let profile_path: String?
}

struct CrewMember: Codable, Identifiable {
    let id: Int
    let name: String
    let job: String?
}


struct VideoResponse: Codable {
    let results: [Video]
}

struct Video: Codable, Identifiable {
    var id: String { key }
    let key: String
    let name: String
    let site: String
    let type: String
}
