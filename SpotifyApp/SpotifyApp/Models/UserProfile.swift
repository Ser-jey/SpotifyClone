//
//  UserProfile.swift
//  SpotifyApp
//
//  Created by Сергей Кривошеев on 23.04.2023.
//

import Foundation

struct UserProfile: Codable {
    let country: String
    let display_name: String
    let email: String
    let explicit_content: [String: Int]
    let external_urls: [String: String]
    //let followers: [String: Codable?]
    let id: String
    let product: String
    let images: [UserImage]
}

struct UserImage: Codable {
    let url: String
}





//href = "https://api.spotify.com/v1/users/314plcjawxnykkw7ijdwsi4cmim4";
//id = 314plcjawxnykkw7ijdwsi4cmim4;
//images =     (
//);
//product = free;
//type = user;
//uri = "spotify:user:314plcjawxnykkw7ijdwsi4cmim4";
