//
//  Router.swift
//  AppTest
//
//  Created by ganesh shankar on 22/11/25.
//

import SwiftUI
import Combine

enum AppRoute: Hashable {
    case movieList
    case movieDetail(id: Int)
}

@MainActor
final class Router: ObservableObject {
    @Published var path = NavigationPath()
    private(set) var routeStack: [AppRoute] = []

    func navigate(to route: AppRoute) {
        routeStack.append(route)
        path.append(route)
    }

    func goBack() {
        guard !routeStack.isEmpty else { return }
        routeStack.removeLast()
        if !path.isEmpty { path.removeLast() }
    }

    func goHome() {
        routeStack.removeAll()
        path.removeLast(path.count)
    }
}

