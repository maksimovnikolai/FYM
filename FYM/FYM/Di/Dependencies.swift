//
//  Dependencies.swift
//  FYM
//
//  Created by Nikolai Maksimov on 01.12.2024.
//

import UIKit

final class Di {
    // MARK: - Private properties
    
    private var window: UIWindow?
    private let navigationController: UINavigationController
    private let coordinatorFactory: CoordinatorFactoryProtocol
    private let screenFactory: ScreenFactoryProtocol
    
    // MARK: - Init
    
    init(window: UIWindow?) {
        self.window = window
        navigationController = UINavigationController()
        coordinatorFactory = CoordinatorFactory()
        screenFactory = ScreenFactory()
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
        let coordinator = coordinatorFactory.makeApplicationCoordinator(navigationController: navigationController, screenFactory: screenFactory)
        completion(coordinator)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        coordinator.start()
    }
}

// MARK: - CoordinatorsFactoryProtocol / Impl

protocol CoordinatorFactoryProtocol {
    func makeApplicationCoordinator(navigationController: UINavigationController, screenFactory: ScreenFactoryProtocol) -> ApplicationCoordinator
    func makeLoginCoordinator(navigation: UINavigationController, screenFactory: ScreenFactoryProtocol) -> LoginCoordinator
}

final class CoordinatorFactory: CoordinatorFactoryProtocol {
    func makeApplicationCoordinator(navigationController: UINavigationController, screenFactory: ScreenFactoryProtocol) -> ApplicationCoordinator {
        ApplicationCoordinator(navigationController: navigationController, coordinatorFactory: self, screenFactory: screenFactory)
    }
    
    func makeLoginCoordinator(navigation: UINavigationController, screenFactory: any ScreenFactoryProtocol) -> LoginCoordinator {
        LoginCoordinator(navigation: navigation, screenFactory: screenFactory)
    }
}

// MARK: - ScreenFactoryProtocol / Impl

protocol ScreenFactoryProtocol {
    func makeLoginController() -> UIViewController
}


final class ScreenFactory: ScreenFactoryProtocol {
    func makeLoginController() -> UIViewController {
        return UIViewController()
    }
}
