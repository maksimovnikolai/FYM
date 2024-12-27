//
//  MovieEndPoint.swift
//  FYM
//
//  Created by Nikolai Maksimov on 24.12.2024.
//

import Foundation

enum NetworkEnvironment {
    case production
}

enum MovieApi {
    case movies(limit: Int)
    case genres
}

extension MovieApi: EndPointType {
    var environmentBaseURL: String {
        switch NetworkManager.environment {
        case .production: return "https://api.kinopoisk.dev/"
        }
    }
    
    var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else {
            fatalError("baseURL could not be configured")
        }
        return url
    }
    
    var path: String {
        switch self {
        case .movies:
            return "v1.4/movie"
        case .genres:
            return "v1/movie/possible-values-by-field"
        }
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var task: HTTPTask {
        let apiKeyHeader = ["X-API-KEY": Secret.movieApiKey]
        switch self {
        case let .movies(limit):
            return .requestParametersAndHeaders(
                bodyParameters: nil,
                urlParameters: ["limit": limit],
                additionHeaders: apiKeyHeader
            )
        case .genres:
            return .requestParametersAndHeaders(
                bodyParameters: nil,
                urlParameters: ["field": "genres.name"],
                additionHeaders: apiKeyHeader
            )
        }
    }
    
    var headers: HTTPHeaders? {
        nil
    }
}
