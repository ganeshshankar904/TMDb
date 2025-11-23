//
//  YouTubePlayerView.swift
//  AppTest
//
//  Created by ganesh shankar on 23/11/25.
//

import SwiftUI
import WebKit

struct YouTubePlayerView: UIViewRepresentable {
    let videoID: String

    func makeUIView(context: Context) -> WKWebView {
        let web = WKWebView()
        web.configuration.allowsInlineMediaPlayback = true
        web.scrollView.isScrollEnabled = false
        return web
    }
        func updateUIView(_ uiView: WKWebView, context: Context) {
            let embed = """
            <!DOCTYPE html>
            <html>
            <head><meta name="viewport" content="initial-scale=1.5"/></head>
            <body style="margin:0; padding:0;">
            <iframe
                width="100%"
                height="100%"
                src="https://www.youtube.com/embed/\(videoID)?playsinline=1&modestbranding=1&rel=0"
                frameborder="0"
                allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
                allowfullscreen>
            </iframe>
            </body>
            </html>
            """
    
            uiView.loadHTMLString(embed, baseURL: nil)
        }
}
