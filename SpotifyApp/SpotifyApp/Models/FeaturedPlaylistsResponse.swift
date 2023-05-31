//
//  FeaturedPlaylistsResponse.swift
//  SpotifyApp
//
//  Created by Сергей Кривошеев on 29.04.2023.
//

import Foundation

struct FeaturedPlaylistsResponse: Codable {
    let playlists: PlaylistResponse
}

struct CategoryPlaylistsResponse: Codable {
    let playlists: PlaylistResponse
}

struct PlaylistResponse: Codable {
    let items: [Playlist]
}

struct User: Codable {
    let display_name: String
    let external_urls: ExternalUrls
    let id: String
}

struct ExternalUrls: Codable {
    let spotify: String
}
