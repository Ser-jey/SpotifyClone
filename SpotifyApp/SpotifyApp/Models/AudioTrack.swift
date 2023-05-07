//
//  AudioTrack.swift
//  SpotifyApp
//
//  Created by Сергей Кривошеев on 30.04.2023.
//

import Foundation

struct AudioTrack: Codable {
    let album: Album
    let artists: [Artist]
    let available_markets: [String]
    let disc_number: Int
    let duration_ms: Int
    let explicit: Bool
    let external_urls: ExternalUrls
    let id: String
    let name: String
    let popularity: Int
}
