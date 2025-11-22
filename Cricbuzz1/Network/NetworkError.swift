//
//  NetworkError.swift
//  Cricbuzz1
//
//  Created by ganesh shankar on 22/11/25.
//

import Foundation

enum NetworkError: Error {
    case badURL
    case badResponse
    case decodingError
    case serverError(Int)
}

