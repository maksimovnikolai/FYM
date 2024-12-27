//
//  NetworkManager.swift
//  FYM
//
//  Created by Nikolai Maksimov on 24.12.2024.
//

import Foundation

enum NetworkCustomError: Error {
    case noData(String)
    case decodingError(String)
    case badResponse(String)
}

protocol NetworkManagerProtocol {
    // TODO: - Добавить методы:
    // - поиск по названию фильма (searchMovie)
    // - поиск актеров (searchActor) и т.д.
    func fetchMovies(limit: Int, completion: @escaping(Result<MovieApiResponse, NetworkCustomError>) -> Void)
}

struct NetworkManager {
    static let environment: NetworkEnvironment = .production
    private let router = Router<MovieApi>()
}

// MARK: - NetworkManagerProtocol

extension NetworkManager: NetworkManagerProtocol {
    func fetchMovies(limit: Int, completion: @escaping (Result<MovieApiResponse, NetworkCustomError>) -> Void) {
        makeRequest(limit: limit, dataType: MovieApiResponse.self, completion: completion)
    }
}

// MARK: - Private methods

private extension NetworkManager {
    func makeRequest<T: Decodable>(limit: Int, dataType: T.Type, completion: @escaping(Result<T, NetworkCustomError>) -> Void) {
        router.request(.movies(limit: limit)) { data, response, error in
            guard let response = response as? HTTPURLResponse else { return }
            guard response.statusCode == 200 else {
                let responseStatusCodeMessage = handleNetworkResponse(response)
                completion(.failure(.badResponse(responseStatusCodeMessage)))
                return
            }
            
            guard let data else {
                completion(.failure(.noData(error?.localizedDescription ?? "No error description")))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let data = try decoder.decode(dataType.self, from: data)
                completion(.success(data))
            } catch {
                completion(.failure(.decodingError(error.localizedDescription)))
            }
        }
    }
    
    func handleNetworkResponse(_ response: HTTPURLResponse) -> String {
        switch response.statusCode {
        case 200...299: return "Ok"
        case 401...500: return "Сначала Вам необходимо пройти аутентификацию."
        case 501...599: return "Плохой запрос."
        case 600:       return "Запрошенный вами URL-адрес устарел."
        default:        return "Сетевой запрос не выполнен."
        }
    }
}
