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
    func makeMainTabBarCoordinator(navigation: UINavigationController, screenFactory: ScreenFactoryProtocol) -> MainTabBarCoordinator
}

final class CoordinatorFactory: CoordinatorFactoryProtocol {
    func makeApplicationCoordinator(navigationController: UINavigationController, screenFactory: ScreenFactoryProtocol) -> ApplicationCoordinator {
        ApplicationCoordinator(navigationController: navigationController, coordinatorFactory: self, screenFactory: screenFactory)
    }
    
    func makeLoginCoordinator(navigation: UINavigationController, screenFactory: any ScreenFactoryProtocol) -> LoginCoordinator {
        LoginCoordinator(navigation: navigation, screenFactory: screenFactory)
    }
    
    func makeMainTabBarCoordinator(navigation: UINavigationController, screenFactory: any ScreenFactoryProtocol) -> MainTabBarCoordinator {
        MainTabBarCoordinator(coordinatorFactory: self, screenFactory: screenFactory, navigation: navigation)
    }
}

// MARK: - ScreenFactoryProtocol / Impl

protocol ScreenFactoryProtocol {
    func makeLoginController(delegate: LoginViewModelDelegate) -> UIViewController
    func makeCreateAccountController(delegate: CreateAccountViewModelDelegate) -> UIViewController
    func makeMainTabBarController() -> UITabBarController
}

final class ScreenFactory: ScreenFactoryProtocol {
    func makeLoginController(delegate: LoginViewModelDelegate) -> UIViewController {
        let viewModel = LoginViewModel()
        viewModel.delegate = delegate
        let loginViewController = LoginViewController(viewModel: viewModel)
        loginViewController.delegate = viewModel
        return loginViewController
    }
    
    func makeCreateAccountController(delegate: CreateAccountViewModelDelegate) -> UIViewController {
        let viewModel = CreateAccountViewModel()
        viewModel.delegate = delegate
        let createAccountViewController = CreateAccountViewController(viewModel: viewModel)
        createAccountViewController.delegate = viewModel
        return createAccountViewController
    }
    
    func makeMainTabBarController() -> UITabBarController {
        let mainTabBarController = MainTabBarController()
        return mainTabBarController
    }
}
