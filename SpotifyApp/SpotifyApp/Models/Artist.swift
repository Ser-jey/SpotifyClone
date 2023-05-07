//
//  Artists.swift
//  SpotifyApp
//
//  Created by Сергей Кривошеев on 29.04.2023.
//

import Foundation

struct Artist: Codable {
    let id: String
    let name: String
    let type: String
    let external_urls: [String: String]
}
