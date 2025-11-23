//
//  MovieDetailView.swift
//  AppTest
//
//  Created by ganesh shankar on 23/11/25.
//

import SwiftUI

struct MovieDetailView: View {

    @EnvironmentObject var router: Router
    @EnvironmentObject var favorites: FavoritesStore
    @StateObject private var vm: MovieDetailViewModel

    init(movieId: Int, service: MovieServiceProtocol? = nil) {
        _vm = StateObject(wrappedValue: MovieDetailViewModel(
            movieId: movieId,
            service: service ?? TMDbService()
        ))
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 12) {

                // MARK: - Favorite Button
                HStack {
                    Spacer()
                    if let id = vm.detail?.id {
                        Button(action: { favorites.toggle(id) }) {
                            Image(systemName: favorites.isFavorite(id) ? "heart.fill" : "heart")
                                .foregroundColor(.red)
                                .font(.title2)
                        }
                    }
                }
                .padding(.horizontal)

                // MARK: - Trailer
                if let key = vm.trailerKey {
                    YouTubePlayerView(videoID: key)
                        .frame(height: MovieDetailConstants.trailerHeight)
                        .cornerRadius(10)
                        .padding(.horizontal)

                    Button(MovieDetailConstants.watchOnYouTube) {
                        if let url = URL(string: "https://www.youtube.com/watch?v=\(key)") {
                            UIApplication.shared.open(url)
                        }
                    }
                    .font(.title2)
                    .foregroundColor(.black)
                    .padding(.leading, 29)
                }

                // MARK: - Movie Details
                if let detail = vm.detail {

                    HStack(alignment: .top, spacing: 12) {
                        AsyncImage(url: detail.posterURL) { phase in
                            switch phase {
                            case .empty:
                                Color.gray.frame(
                                    width: MovieDetailConstants.posterWidth,
                                    height: MovieDetailConstants.posterHeight
                                )
                            case .success(let img):
                                img.resizable()
                                    .scaledToFill()
                                    .frame(
                                        width: MovieDetailConstants.posterWidth,
                                        height: MovieDetailConstants.posterHeight
                                    )
                                    .clipped()
                            default:
                                Color.gray.frame(
                                    width: MovieDetailConstants.posterWidth,
                                    height: MovieDetailConstants.posterHeight
                                )
                            }
                        }
                        .cornerRadius(8)

                        VStack(alignment: .leading, spacing: 8) {
                            Text(detail.title)
                                .font(.title2)
                                .bold()

                            if let runtime = detail.runtime {
                                Text(MovieDetailConstants.duration + "\(runtime) min")
                            }

                            if let rating = detail.voteAverage {
                                Text(MovieDetailConstants.rating + "\(String(format: MovieDetailConstants.ratingFormat, rating))/10")
                            }
                        }
                    }
                    .padding(.horizontal)

                    // Genres
                    if let genres = detail.genres, !genres.isEmpty {
                        Text(MovieDetailConstants.genres + genres.map { $0.name }.joined(separator: ", "))
                            .padding(.horizontal)
                    }

                    // Overview
                    if let overview = detail.overview {
                        Text(overview)
                            .padding(.horizontal)
                    }

                    // MARK: - Cast
                    if let cast = detail.credits?.cast, !cast.isEmpty {
                        Text(MovieDetailConstants.cast)
                            .font(.headline)
                            .padding(.horizontal)

                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 12) {
                                ForEach(cast.prefix(MovieDetailConstants.castLimit)) { member in
                                    VStack {
                                        AsyncImage(url: member.profileURL) { phase in
                                            switch phase {
                                            case .empty:
                                                Color.gray.frame(
                                                    width: MovieDetailConstants.castImageWidth,
                                                    height: MovieDetailConstants.castImageHeight
                                                )
                                            case .success(let img):
                                                img.resizable()
                                                    .scaledToFill()
                                                    .frame(
                                                        width: MovieDetailConstants.castImageWidth,
                                                        height: MovieDetailConstants.castImageHeight
                                                    )
                                                    .clipped()
                                            default:
                                                Color.gray.frame(
                                                    width: MovieDetailConstants.castImageWidth,
                                                    height: MovieDetailConstants.castImageHeight
                                                )
                                            }
                                        }
                                        .cornerRadius(6)

                                        Text(member.name ?? "-")
                                            .font(.caption)
                                            .frame(width: MovieDetailConstants.castImageWidth)
                                            .multilineTextAlignment(.center)
                                            .lineLimit(1)

                                        Text(member.character ?? "")
                                            .font(.caption2)
                                            .foregroundColor(.gray)
                                            .frame(width: MovieDetailConstants.castImageWidth)
                                            .multilineTextAlignment(.center)
                                            .lineLimit(1)
                                    }
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                }
            }
            .padding(.top)
        }
        .navigationTitle("")
        .task { await vm.load() }
    }
}
// MARK: - Constants in UI and String
enum MovieDetailConstants {
    // MARK: - UI Sizes
    static let trailerHeight: CGFloat = 220
    static let posterWidth: CGFloat = 120
    static let posterHeight: CGFloat = 180
    static let castImageWidth: CGFloat = 80
    static let castImageHeight: CGFloat = 120

    // MARK: - Strings
    static let watchOnYouTube = "Watch on YouTube"
    static let duration = "Duration: "
    static let rating = "Rating: "
    static let genres = "Genres: "
    static let cast = "Cast"
    static let ratingFormat = "%.1f"

    // MARK: - Count Limits
    static let castLimit = 12
}
