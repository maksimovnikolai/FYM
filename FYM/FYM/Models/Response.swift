//
//  Response.swift
//  FYM
//
//  Created by Nikolai Maksimov on 24.12.2024.
//

import Foundation

struct MovieApiResponse: Decodable {
    let docs: [Movie]
}
