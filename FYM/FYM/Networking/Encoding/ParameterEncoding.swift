//
//  ParameterEncoding.swift
//  FYM
//
//  Created by Nikolai Maksimov on 24.12.2024.
//

import Foundation

typealias Parameters = [String: Any]

protocol ParameterEncoder {
    static func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws
}

enum NetworkError: String, Error {
    case parametersNil = "Parameters were nil."
    case encodingFailed = "Parameter encoding failed."
    case missingURL = "URL is nil"
}
