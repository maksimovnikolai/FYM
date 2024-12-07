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
    private var isLogin = false
    
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
            let vc = UIViewController()
            vc.view.backgroundColor = .green
            navigationController.pushViewController(vc, animated: false)
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
}
