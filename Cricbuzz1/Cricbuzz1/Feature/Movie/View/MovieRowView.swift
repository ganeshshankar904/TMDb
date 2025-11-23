//
//  MovieRowView.swift
//  AppTest
//
//  Created by ganesh shankar on 23/11/25.
//
import SwiftUI
struct MovieRowView: View {
    let movie: Movie

    var body: some View {
        HStack(spacing: 12) {
            AsyncImage(url: movie.posterURL) { phase in
                switch phase {
                case .empty:
                    Rectangle()
                        .fill(Color.gray.opacity(0.3))
                        .frame(width: 80, height: 120)
                        .cornerRadius(8)

                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 80, height: 120)
                        .clipped()
                        .cornerRadius(8)

                case .failure:
                    Rectangle()
                        .fill(Color.red.opacity(0.3))
                        .frame(width: 80, height: 120)
                        .cornerRadius(8)

                @unknown default:
                    EmptyView()
                }
            }

            VStack(alignment: .leading, spacing: 6) {
                Text(movie.title)
                    .font(.headline)

                Text(movie.overview ?? "")
                    .font(.subheadline)
                    .lineLimit(2)
                    .foregroundColor(.secondary)
            }

            Spacer()
        }
        .padding(.vertical, 8)
    }
}
