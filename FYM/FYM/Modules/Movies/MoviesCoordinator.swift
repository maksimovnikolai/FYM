//
//  MoviesCoordinator.swift
//  FYM
//
//  Created by Nikolai Maksimov on 19.12.2024.
//

import UIKit

final class MoviesCoordinator: BaseCoordinator {
    var rootController: UIViewController {
        navigation
    }
    
    // MARK: - Private properties
    private let screenFactory: ScreenFactoryProtocol
    private let navigation: UINavigationController
    private let networkManager: NetworkManagerProtocol
    
    // MARK: - Init
    
    init(screenFactory: ScreenFactoryProtocol, networkManager: NetworkManagerProtocol) {
        self.screenFactory = screenFactory
        self.navigation = UINavigationController()
        self.networkManager = networkManager
        super.init()
        configureRootController()
    }
}

// MARK: - Private methods

private extension MoviesCoordinator {
    func configureRootController() {
        let moviesController = screenFactory.makeMoviesController(networkManager: networkManager)
        moviesController.navigationItem.title = "Фильмы 🍿"
        navigation.pushViewController(moviesController, animated: true)
        navigation.navigationBar.prefersLargeTitles = true
        makeTabBarItem(for: navigation)
    }
}

// MARK: - TabBarItemFactoryProtocol

extension MoviesCoordinator: TabBarItemFactoryProtocol {
    func makeTabBarItem(for navigation: UINavigationController) {
        makeTabBarItem(
            navigation: navigation,
            title: "Фильмы",
            image: "movieclapper",
            selectedImage: "movieclapper.fill"
        )
    }
}
