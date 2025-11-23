//
//  Cricbuzz1App.swift
//  Cricbuzz1
//
//  Created by ganesh shankar on 22/11/25.
//

import SwiftUI

@main
struct MovieAppMain: App {
    @StateObject private var router = Router()
    @StateObject private var favorites = FavoritesStore()

    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $router.path) {
                LoginView()
                    .environmentObject(router)
                    .environmentObject(favorites)
                    .navigationDestination(for: AppRoute.self) { route in
                        switch route {
                        case .movieList:
                            MovieListView()
                                .environmentObject(router)
                                .environmentObject(favorites)
                        case .movieDetail(let id):
                            MovieDetailView(movieId: id)
                                .environmentObject(router)
                                .environmentObject(favorites)
                        }
                    }
            }
        }
    }
}
