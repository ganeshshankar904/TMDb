//
//  LoginViewModel.swift
//  AppTest
//
//  Created by ganesh shankar on 22/11/25.
//

import Foundation
import Combine
@MainActor
final class LoginViewModel: ObservableObject {
    @Published var username: String = ""
    @Published var password: String = ""

    // Minimal demo login - replace with real auth for production
    func login() -> Bool {
        // simple demo: admin / 1234
        username.trimmingCharacters(in: .whitespacesAndNewlines).lowercased() == "admin"
            && password == "1234"
    }
}

