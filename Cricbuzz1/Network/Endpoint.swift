//
//  Endpoint.swift
//  Cricbuzz1
//
//  Created by ganesh shankar on 22/11/25.
//

import Foundation

enum Endpoint {
    case popular
    case search(query: String)
    case detail(id: Int)
    case videos(id: Int)

    var path: String {
        switch self {
        case .popular:
            return "/movie/popular"
        case .search:
            return "/search/movie"
        case .detail(let id):
            return "/movie/\(id)"
        case .videos(let id):
            return "/movie/\(id)/videos"
        }
    }

    var queryItems: [URLQueryItem] {
        switch self {
        case .popular:
            return []
        case .search(let query):
            return [URLQueryItem(name: "query", value: query)]
        case .detail:
            return [URLQueryItem(name: "append_to_response", value: "credits")]
        case .videos:
            return []
        }
    }
}

