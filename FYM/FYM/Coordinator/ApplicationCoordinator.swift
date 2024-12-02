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
        runLoginFlow()
    }
}

// MARK: - Private methods

private extension ApplicationCoordinator {
    func runLoginFlow() {
        let loginCoordinator = coordinatorFactory.makeLoginCoordinator(navigation: navigationController, screenFactory: screenFactory)
        loginCoordinator.start()
    }
}
