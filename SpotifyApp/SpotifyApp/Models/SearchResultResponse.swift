//
//  SearchResultResponse.swift
//  SpotifyApp
//
//  Created by Сергей Кривошеев on 02.06.2023.
//

import Foundation

struct SearchResultResponse: Codable {
    let albums: SearchAlbumResponse
    let artists: SearchArtistResponse
    let playlists: SearchPlaylistResponse
    let tracks: SearchTrackResponse
}

struct SearchAlbumResponse: Codable {
    let items: [Album]
}

struct SearchArtistResponse: Codable {
    let items: [Artist]
}

struct SearchPlaylistResponse: Codable {
    let items: [Playlist]
}

struct SearchTrackResponse: Codable {
    let items: [AudioTrack]
}


