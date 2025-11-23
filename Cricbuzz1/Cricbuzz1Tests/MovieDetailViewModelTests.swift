//
//  MovieDetailViewModelTests.swift
//  Cricbuzz1Tests
//
//  Created by ganesh shankar on 23/11/25.
//

import XCTest
@testable import Cricbuzz1

@MainActor   
final class MovieDetailViewModelTests: XCTestCase {

    func test_load_populatesDetailAndTrailer() async {

        // Arrange
        let mock = MockMovieService()

        let credits = CreditsResponse(
            id: 10,
            cast: [
                Cast(id: 100, name: "Actor", character: "Hero", profilePath: nil)
            ],
            crew: nil
        )

        mock.mockDetail = MovieDetail(
            id: 10,
            title: "Detail",
            overview: "o",
            genres: [Genre(id: 1, name: "Action")],
            runtime: 120,
            voteAverage: 8.3,
            posterPath: nil,
            releaseDate: nil,
            credits: credits,
            videos: nil
        )

        mock.mockVideos = [
            Video(id: "v1",
                  key: "abc123",
                  name: "Trailer",
                  site: "YouTube",
                  type: "Trailer")
        ]

        // Act
        let vm = MovieDetailViewModel(movieId: 10, service: mock)
        await vm.load()

        // Assert
        XCTAssertEqual(vm.detail?.title, "Detail")
        XCTAssertEqual(vm.videos.first?.key, "abc123")
        XCTAssertEqual(vm.trailerKey, "abc123")
    }
}
