//
//  ApplicationCoordinator.swift
//  FYM
//
//  Created by Nikolai Maksimov on 01.12.2024.
//

import UIKit

final class ApplicationCoordinator: BaseCoordinator {
    // MARK: - Private properties
    
    private let navigationController: UINavigationController
    private let coordinatorFactory: CoordinatorFactoryProtocol
    private let screenFactory: ScreenFactoryProtocol
    private var isLogin = true
    
    // MARK: - Init
    
    init(
        navigationController: UINavigationController,
        coordinatorFactory: CoordinatorFactoryProtocol,
        screenFactory: ScreenFactoryProtocol
    ) {
        self.navigationController = navigationController
        self.coordinatorFactory = coordinatorFactory
        self.screenFactory = screenFactory
    }
    
    override func start() {
        navigationController.viewControllers = []
        if isLogin {
            runTabBarFlow()
        } else {
            runLoginFlow()
        }
    }
}

// MARK: - Private methods

private extension ApplicationCoordinator {
    func runLoginFlow() {
        let loginCoordinator = coordinatorFactory.makeLoginCoordinator(navigation: navigationController, screenFactory: screenFactory)
        loginCoordinator.finishFlow = { [weak self, weak loginCoordinator] in
            self?.isLogin = true
            self?.start()
            self?.removeDependency(loginCoordinator)
        }
        addDependency(loginCoordinator)
        loginCoordinator.start()
    }
    
    func runTabBarFlow() {
        let mainTabBarCoordinator = coordinatorFactory.makeMainTabBarCoordinator(navigation: navigationController, screenFactory: screenFactory)
        mainTabBarCoordinator.finishFlow = { [weak self, weak mainTabBarCoordinator] in
            self?.isLogin = false
            self?.start()
            self?.removeDependency(mainTabBarCoordinator)
        }
        addDependency(mainTabBarCoordinator)
        mainTabBarCoordinator.start()
    }
}
