//
//  Movie.swift
//  Cricbuzz1
//
//  Created by ganesh shankar on 22/11/25.
//

import Foundation

// MARK: - Movie (short)
struct Movie: Identifiable, Codable {
    let id: Int
    let title: String
    let overview: String?
    let poster_path: String?
    let vote_average: Double?
    let runtime: Int? // may not be present in list endpoint
    let release_date: String?
}

// MARK: - Popular Response
struct MoviesResponse: Codable {
    let page: Int
    let results: [Movie]
    let total_results: Int
    let total_pages: Int
}

// MARK: - MovieDetail
struct MovieDetail: Codable {
    let id: Int
    let title: String
    let overview: String?
    let genres: [Genre]?
    let runtime: Int?
    let vote_average: Double?
    let poster_path: String?
    let release_date: String?
    let credits: CreditsResponse?
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

// MARK: - Videos
struct VideosResponse: Codable {
    let id: Int
    let results: [Video]
}

struct Video: Codable, Identifiable {
    let id: String
    let key: String
    let name: String
    let site: String
    let type: String
}
