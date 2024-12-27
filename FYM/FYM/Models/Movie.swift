//
//  Movie.swift
//  FYM
//
//  Created by Nikolai Maksimov on 24.12.2024.
//

import Foundation

struct Movie: Decodable {
    let id: Int
    let name: String
    let year: Int
    let description: String
    let ageRating: Int
    let poster: Poster
}

struct Poster: Decodable {
    let url: String
}
