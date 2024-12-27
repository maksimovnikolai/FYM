//
//  MoviesViewModel.swift
//  FYM
//
//  Created by Nikolai Maksimov on 19.12.2024.
//

import Foundation

protocol MoviesViewModelProtocol {}

final class MoviesViewModel: MoviesViewModelProtocol {
    
    // MARK: - Private properties
    
    private let networkManager: NetworkManagerProtocol

    // MARK: - Init
    
    init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
    }
}

// MARK: - MoviesViewDelegate

extension MoviesViewModel: MoviesViewDelegate {}

// MARK: - Private methods

private extension MoviesViewModel {}
