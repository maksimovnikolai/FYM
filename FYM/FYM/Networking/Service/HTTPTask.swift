//
//  HTTPTask.swift
//  FYM
//
//  Created by Nikolai Maksimov on 24.12.2024.
//

import Foundation

typealias HTTPHeaders = [String: String]

enum HTTPTask {
    case request
    case requestParameters(bodyParameters: Parameters?, urlParameters: Parameters?)
    case requestParametersAndHeaders(bodyParameters: Parameters?, urlParameters: Parameters?, additionHeaders: HTTPHeaders?)
}
