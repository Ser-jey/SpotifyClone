//
//  SearchResult.swift
//  SpotifyApp
//
//  Created by Сергей Кривошеев on 02.06.2023.
//

import Foundation

enum SearchResult {
    case artist(model: Artist)
    case album(model: Album)
    case playlist(model: Playlist)
    case track(model: AudioTrack)
}
