//
//  MovieRowView.swift
//  Cricbuzz1
//
//  Created by ganesh shankar on 22/11/25.
//

import SwiftUI

struct MovieRowView: View {
    let movie: Movie
    @EnvironmentObject var favorites: FavoritesStore

    var body: some View {
        HStack {
            AsyncImage(url: URL(string: APIConfig.imageBaseURL + (movie.posterPath ?? ""))) { img in
                img.resizable()
            } placeholder: {
                Color.gray.opacity(0.3)
            }
            .frame(width: 70, height: 100)
            .cornerRadius(8)

            VStack(alignment: .leading) {
                Text(movie.title)
                    .font(.headline)

                Text("Rating: \(movie.voteAverage, specifier: "%.1f")")
                    .font(.subheadline)
            }

            Spacer()

            Button {
                favorites.toggle(id: movie.id)
            } label: {
                Image(systemName: favorites.isFavorite(id: movie.id) ? "heart.fill" : "heart")
                    .foregroundColor(.red)
            }
        }
        .padding(.vertical, 4)
    }
}

