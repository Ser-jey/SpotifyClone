//
//  RecommendationsResponse.swift
//  SpotifyApp
//
//  Created by Сергей Кривошеев on 30.04.2023.
//

import Foundation

struct RecommendationsResponse: Codable {
    let seeds: [GenreInfo]
    let tracks: [AudioTrack]
}

struct GenreInfo: Codable {
    let id: String
}
