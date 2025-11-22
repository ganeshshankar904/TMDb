//
//  FavoritesStoreProtocol.swift
//  Cricbuzz1
//
//  Created by ganesh shankar on 22/11/25.
//

import Foundation

protocol FavoritesStoreProtocol: AnyObject {
    var favorites: Set<Int> { get }
    func toggle(id: Int)
    func isFavorite(id: Int) -> Bool
}

