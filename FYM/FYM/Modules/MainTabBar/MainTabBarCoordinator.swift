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
    
    // MARK: - Init
    
    init(
        coordinatorFactory: CoordinatorFactoryProtocol,
        screenFactory: ScreenFactoryProtocol,
        navigation: UINavigationController
    ) {
        self.coordinatorFactory = coordinatorFactory
        self.screenFactory = screenFactory
        self.navigation = navigation
    }
    
    override func start() {
        runMainTabBarFlow()
    }
}

// MARK: - Private methods

private extension MainTabBarCoordinator {
    func runMainTabBarFlow() {
        let mainTabBarController = screenFactory.makeMainTabBarController()
        navigation.pushViewController(mainTabBarController, animated: false)
        navigation.navigationBar.isHidden = true
    }
}
