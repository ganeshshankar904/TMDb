//
//  FavoritesStore.swift
//  Cricbuzz1
//
//  Created by ganesh shankar on 22/11/25.
//
import Foundation
import Combine

final class FavoritesStore: ObservableObject, FavoritesStoreProtocol {
    @Published private(set) var favorites: Set<Int> = []

    private let key = "favorite_movies"

    init() {
        load()
    }

    private func load() {
        if let ids = UserDefaults.standard.array(forKey: key) as? [Int] {
            favorites = Set(ids)
        }
    }

    private func save() {
        UserDefaults.standard.set(Array(favorites), forKey: key)
    }

    func toggle(id: Int) {
        if favorites.contains(id) {
            favorites.remove(id)
        } else {
            favorites.insert(id)
        }
        save()
    }

    func isFavorite(id: Int) -> Bool {
        favorites.contains(id)
    }
}

