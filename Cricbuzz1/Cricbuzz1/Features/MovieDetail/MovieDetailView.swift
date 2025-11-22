//
//  MovieDetailView.swift
//  Cricbuzz1
//
//  Created by ganesh shankar on 22/11/25.
//

import SwiftUI
import AVKit

struct MovieDetailView: View {
    let movieId: Int
    @StateObject private var vm = MovieDetailViewModel()
    @EnvironmentObject var favorites: FavoritesStore

    var body: some View {
        ScrollView {
            if let movie = vm.movie {
                
                if let trailer = vm.trailers.first {
                    VideoPlayerView(videoKey: trailer.key)
                        .frame(height: 220)
                }

                VStack(alignment: .leading, spacing: 12) {

                    HStack {
                        Text(movie.title)
                            .font(.title)
                            .bold()

                        Spacer()

                        Button {
                            favorites.toggle(id: movie.id)
                        } label: {
                            Image(systemName: favorites.isFavorite(id: movie.id) ? "heart.fill" : "heart")
                                .font(.title2)
                                .foregroundColor(.red)
                        }
                    }

                    Text(movie.overview ?? "")
                        .font(.body)

                    Text("Genres: \(movie.genres.map{$0.name}.joined(separator: ", "))")

                    if let runtime = movie.runtime {
                        Text("Duration: \(runtime) mins")
                    }

                    Text("Rating: \(movie.voteAverage, specifier: "%.1f")")
                }
                .padding()
            }
        }
        .navigationTitle("Details")
        .task {
            await vm.load(id: movieId)
        }
    }
}

