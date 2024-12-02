//
//  Dependencies.swift
//  FYM
//
//  Created by Nikolai Maksimov on 01.12.2024.
//

import UIKit

final class Di {
    // MARK: - Properties
    
    private var window: UIWindow?
    private let navigationController: UINavigationController
    private let coordinatorFactory: CoordinatorFactoryProtocol
    
    // MARK: - Init
    
    init(window: UIWindow?) {
        self.window = window
        navigationController = UINavigationController()
        coordinatorFactory = CoordinatorFactory()
    }
}

// MARK: - AppFactoryProtocol / Impl

protocol AppFactoryProtocol {
    typealias RootController = UINavigationController
    func makeKeyWindowWithCoordinator(windowScene: UIWindowScene, completion: (ApplicationCoordinator) -> Void)
}

extension Di: AppFactoryProtocol {
    func makeKeyWindowWithCoordinator(windowScene: UIWindowScene, completion: (ApplicationCoordinator) -> Void) {
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        let coordinator = coordinatorFactory.makeApplicationCoordinator(navigationController: navigationController)
        completion(coordinator)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        coordinator.start()
    }
}

// MARK: - CoordinatorsFactoryProtocol / Impl

protocol CoordinatorFactoryProtocol {
    func makeApplicationCoordinator(navigationController: UINavigationController) -> ApplicationCoordinator
}

final class CoordinatorFactory: CoordinatorFactoryProtocol {
    func makeApplicationCoordinator(navigationController: UINavigationController) -> ApplicationCoordinator {
        ApplicationCoordinator(navigationController: navigationController, coordinatorFactory: self)
    }
}
