//
//  SettingsModel.swift
//  SpotifyApp
//
//  Created by Сергей Кривошеев on 25.04.2023.
//

import Foundation

struct Section {
    let title: String
    let options: [Option]
}

struct Option {
    let title: String
    let handler: () -> Void
}
