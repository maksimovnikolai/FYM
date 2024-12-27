//
//  URLParameterEncoder.swift
//  FYM
//
//  Created by Nikolai Maksimov on 24.12.2024.
//

import Foundation

struct URLParameterEncoder: ParameterEncoder {
    static func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws {
        guard let url = urlRequest.url else { throw NetworkError.missingURL }
        if var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false), !parameters.isEmpty {
            /// захардкодил параметры, т.к. невозможно передавать словарь с повторяющимися ключами (notNullFields)
            let myQueryItems: [URLQueryItem] = [
                URLQueryItem(name: "notNullFields", value: "id"),
                URLQueryItem(name: "notNullFields", value: "name"),
                URLQueryItem(name: "notNullFields", value: "year"),
                URLQueryItem(name: "notNullFields", value: "description"),
                URLQueryItem(name: "notNullFields", value: "ageRating"),
                URLQueryItem(name: "notNullFields", value: "poster.url")
            ]
            urlComponents.queryItems = myQueryItems
            
            for (key, value) in parameters {
                let queryItem = URLQueryItem(name: key, value: "\(value)".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed))
                urlComponents.queryItems?.append(queryItem)
            }
            urlRequest.url = urlComponents.url
        }
        
        if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
            urlRequest.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
        }
    }
}
