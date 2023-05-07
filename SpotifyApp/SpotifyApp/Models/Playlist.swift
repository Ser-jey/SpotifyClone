//
//  Playlist.swift
//  SpotifyApp
//
//  Created by Сергей Кривошеев on 30.04.2023.
//

import Foundation

struct Playlist: Codable {
    let description: String
    let external_urls: ExternalUrls
    let id: String
    let images: [APIImage]
    let name: String
    let owner: User
}
