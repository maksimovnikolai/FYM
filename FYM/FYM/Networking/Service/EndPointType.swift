//
//  EndPointType.swift
//  FYM
//
//  Created by Nikolai Maksimov on 24.12.2024.
//

import Foundation

protocol EndPointType {
    var baseURL: URL { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var task: HTTPTask { get }
    var headers: HTTPHeaders? { get }
}
