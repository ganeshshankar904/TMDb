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
        _vm = StateObject(wrappedValue: MovieDetailViewModel(movieId: movieId, service: service ?? TMDbService()))
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 12) {
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

                if let key = vm.trailerKey {
                    YouTubePlayerView(videoID: key)
                        .frame(height: 220)
                        .cornerRadius(10)
                        .padding(.horizontal)
                    Button("Watch on YouTube") {
                        if let url = URL(string: "https://www.youtube.com/watch?v=\(key)") {
                                                    UIApplication.shared.open(url)
                                }
                        }
                        .font(.title2)
                        .foregroundColor(.black)
                        .padding(.leading , 29)
                }

                if let detail = vm.detail {
                    HStack(alignment: .top, spacing: 12) {
                        AsyncImage(url: detail.posterURL) { phase in
                            switch phase {
                            case .empty:
                                Color.gray.frame(width: 120, height: 180)
                            case .success(let img):
                                img.resizable().scaledToFill().frame(width: 120, height: 180).clipped()
                            default:
                                Color.gray.frame(width: 120, height: 180)
                            }
                        }
                        .cornerRadius(8)

                        VStack(alignment: .leading, spacing: 8) {
                            Text(detail.title)
                                .font(.title2)
                                .bold()

                            if let runtime = detail.runtime {
                                Text("Duration: \(runtime) min")
                            }

                            if let rating = detail.voteAverage {
                                Text("Rating: \(String(format: "%.1f", rating))/10")
                            }
                        }
                    }
                    .padding(.horizontal)
                    

                    if let genres = detail.genres, !genres.isEmpty {
                        Text("Genres: " + genres.map { $0.name }.joined(separator: ", "))
                            .padding(.horizontal)
                    }

                    if let overview = detail.overview {
                        Text(overview)
                            .padding(.horizontal)
                    }

                    if let cast = detail.credits?.cast, !cast.isEmpty {
                        Text("Cast")
                            .font(.headline)
                            .padding(.horizontal)

                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 12) {
                                ForEach(cast.prefix(12)) { member in
                                    VStack {
                                        AsyncImage(url: member.profileURL) { phase in
                                            switch phase {
                                            case .empty:
                                                Color.gray.frame(width: 80, height: 120)
                                            case .success(let img):
                                                img.resizable()
                                                    .scaledToFill()
                                                    .frame(width: 80, height: 120)
                                                    .clipped()
                                            default:
                                                Color.gray.frame(width: 80, height: 120)
                                            }
                                        }
                                        .cornerRadius(6)

                                        Text(member.name ?? "-")
                                            .font(.caption)
                                            .frame(width: 80)
                                            .multilineTextAlignment(.center)
                                            .lineLimit(1)

                                        Text(member.character ?? "")
                                            .font(.caption2)
                                            .frame(width: 80)
                                            .foregroundColor(.gray)
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
