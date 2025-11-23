//
//  MovieDetail.swift
//  AppTest
//
//  Created by ganesh shankar on 22/11/25.
//
import Foundation

struct MovieDetail: Codable, Equatable {
    let id: Int
    let title: String
    let overview: String?
    let genres: [Genre]?
    let runtime: Int?
    let voteAverage: Double?
    let posterPath: String?
    let releaseDate: String?
    let credits: CreditsResponse?
    let videos: VideoResponse?    
}
struct VideoResponse: Codable, Equatable {
    let id: Int?
    let results: [Video]
}

struct Video: Codable, Identifiable, Equatable {
    let id: String
    let key: String
    let name: String?
    let site: String?
    let type: String?

    var youtubeEmbedURL: URL? {
        guard site?.lowercased() == "youtube" else { return nil }
        return URL(string: "https://www.youtube.com/embed/\(key)")
    }

    var youtubeWatchURL: URL? {
        guard site?.lowercased() == "youtube" else { return nil }
        return URL(string: "https://www.youtube.com/watch?v=\(key)")
    }
}
struct CreditsResponse: Codable, Equatable {
    let id: Int?
    let cast: [Cast]?
    let crew: [Crew]?
}

struct Cast: Codable, Identifiable, Equatable {
    let id: Int
    let name: String?
    let character: String?
    let profilePath: String?

    var profileURL: URL? {
        guard let path = profilePath else { return nil }
        return URL(string: APIConfig.imageBaseURL + path)
    }
}

struct Crew: Codable, Identifiable, Equatable {
    let id: Int
    let name: String?
    let job: String?
}

extension MovieDetail {
    var posterURL: URL? {
        guard let path = posterPath else { return nil }
        return URL(string: "https://image.tmdb.org/t/p/w500\(path)")
    }
}
