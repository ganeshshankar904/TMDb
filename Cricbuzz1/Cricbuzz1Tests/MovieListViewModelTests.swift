//
//  MovieListViewModelTests.swift
//  Cricbuzz1Tests
//
//  Created by ganesh shankar on 23/11/25.
//

import XCTest
@testable import Cricbuzz1 
@MainActor
final class MovieListViewModelTests: XCTestCase {

    func test_loadPopular_withMockService_populatesMovies() async {
        // Arrange
        let mock = MockMovieService()
        mock.mockMovies = [
            Movie(id: 1,
                  title: "A",
                  overview: "o",
                  posterPath: nil,
                  backdropPath: nil,
                  voteAverage: 7.0,
                  releaseDate: nil,
                  runtime: nil,
                  genres: nil)
        ]

        let vm = MovieListViewModel(service: mock)

        // Act
        await vm.loadPopular()

        // Assert
        XCTAssertEqual(vm.movies.count, 1)
        XCTAssertEqual(vm.movies.first?.title, "A")
    }

    func test_search_withMockService_setsMovies() async {
        // Arrange
        let mock = MockMovieService()
        mock.mockMovies = [
            Movie(id: 2,
                  title: "Search",
                  overview: nil,
                  posterPath: nil,
                  backdropPath: nil,
                  voteAverage: 8.0,
                  releaseDate: nil,
                  runtime: nil,
                  genres: nil)
        ]

        let vm = MovieListViewModel(service: mock)

        vm.searchText = "any"

        // Act
        await vm.search()

        // Assert
        XCTAssertEqual(vm.movies.count, 1)
        XCTAssertEqual(vm.movies.first?.title, "Search")
    }
}

