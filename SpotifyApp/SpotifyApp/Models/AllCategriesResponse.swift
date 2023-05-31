//
//  AllCategriesResponse.swift
//  SpotifyApp
//
//  Created by Сергей Кривошеев on 31.05.2023.
//

import Foundation

struct AllCategriesResponse: Codable {
    let categories: Categories
}

struct Categories: Codable {
    let items: [Category]
}

struct Category: Codable {
    let id: String
    let name: String
    let icons: [APIImage]
}
