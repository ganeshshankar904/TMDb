//
//  YouTubePlayerView.swift
//  Cricbuzz1
//
//  Created by ganesh shankar on 22/11/25.
//

import SwiftUI
import WebKit

struct VideoPlayerView: UIViewRepresentable {
    let videoKey: String

    func makeUIView(context: Context) -> WKWebView {
        WKWebView()
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        let url = URL(string: "https://www.youtube.com/embed/\(videoKey)")!
        uiView.load(URLRequest(url: url))
    }
}

