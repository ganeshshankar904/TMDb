//
//  FavoritesStore.swift
//  AppTest
//
//  Created by ganesh shankar on 22/11/25.
//
import Foundation
import Combine

final class FavoritesStore: ObservableObject {
    @Published private(set) var favorites: Set<Int> = []
    private let key = "favorites.movie.ids"

    init() { load() }

    private func load() {
        if let arr = UserDefaults.standard.array(forKey: key) as? [Int] {
            favorites = Set(arr)
        }
    }

    private func save() {
        UserDefaults.standard.set(Array(favorites), forKey: key)
    }

    func toggle(_ id: Int) {
        if favorites.contains(id) { favorites.remove(id) } else { favorites.insert(id) }
        save()
    }

    func isFavorite(_ id: Int) -> Bool {
        favorites.contains(id)
    }
}

