//
//  MainTabBarCoordinator.swift
//  FYM
//
//  Created by Nikolai Maksimov on 16.12.2024.
//

import UIKit

final class MainTabBarCoordinator: BaseCoordinator {
    var finishFlow: (() -> Void)?
    
    // MARK: - Private properties
    
    private let coordinatorFactory: CoordinatorFactoryProtocol
    private let screenFactory: ScreenFactoryProtocol
    private let navigation: UINavigationController
    private let networkManager: NetworkManagerProtocol
    
    // MARK: - Init
    
    init(
        coordinatorFactory: CoordinatorFactoryProtocol,
        screenFactory: ScreenFactoryProtocol,
        navigation: UINavigationController,
        networkManager: NetworkManagerProtocol
    ) {
        self.coordinatorFactory = coordinatorFactory
        self.screenFactory = screenFactory
        self.navigation = navigation
        self.networkManager = networkManager
    }
    
    override func start() {
        runMainTabBarFlow()
    }
}

// MARK: - Private methods

private extension MainTabBarCoordinator {
    func runMainTabBarFlow() {
        let mainTabBarController = screenFactory.makeMainTabBarController()
        let moviesCoordinator = coordinatorFactory.makeMoviesCoordinator(screenFactory: screenFactory, networkManager: networkManager)
        addDependency(moviesCoordinator)
        
        let settingsCoordinator = coordinatorFactory.makeSettingsCoordinator(screenFactory: screenFactory)
        settingsCoordinator.finishFlow = { [weak self, weak settingsCoordinator] in
            self?.removeDependency(settingsCoordinator)
            self?.removeDependency(moviesCoordinator)
            self?.finishFlow?()
        }
        addDependency(settingsCoordinator)
        mainTabBarController.viewControllers = [moviesCoordinator.rootController, settingsCoordinator.rootController]
        navigation.pushViewController(mainTabBarController, animated: false)
        navigation.navigationBar.isHidden = true
    }
}
