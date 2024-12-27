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
    private let networkManager: NetworkManagerProtocol
    
    // MARK: - Init
    
    init(window: UIWindow?) {
        self.window = window
        navigationController = UINavigationController()
        coordinatorFactory = CoordinatorFactory()
        screenFactory = ScreenFactory()
        networkManager = NetworkManager()
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
        let coordinator = coordinatorFactory.makeApplicationCoordinator(
            navigationController: navigationController,
            screenFactory: screenFactory,
            networkManager: networkManager
        )
        completion(coordinator)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        coordinator.start()
    }
}

// MARK: - CoordinatorsFactoryProtocol / Impl

protocol CoordinatorFactoryProtocol {
    func makeApplicationCoordinator(
        navigationController: UINavigationController,
        screenFactory: ScreenFactoryProtocol,
        networkManager: NetworkManagerProtocol
    ) -> ApplicationCoordinator
    func makeLoginCoordinator(navigation: UINavigationController, screenFactory: ScreenFactoryProtocol) -> LoginCoordinator
    func makeMainTabBarCoordinator(navigation: UINavigationController, screenFactory: ScreenFactoryProtocol, networkManager: NetworkManagerProtocol) -> MainTabBarCoordinator
    func makeMoviesCoordinator(screenFactory: ScreenFactoryProtocol, networkManager: NetworkManagerProtocol) -> MoviesCoordinator
    func makeSettingsCoordinator(screenFactory: ScreenFactoryProtocol) -> SettingsCoordinator
}

final class CoordinatorFactory: CoordinatorFactoryProtocol {
    func makeApplicationCoordinator(
        navigationController: UINavigationController,
        screenFactory: ScreenFactoryProtocol,
        networkManager: NetworkManagerProtocol
    ) -> ApplicationCoordinator {
        ApplicationCoordinator(
            navigationController: navigationController,
            coordinatorFactory: self,
            screenFactory: screenFactory,
            networkManager: networkManager
        )
    }
    
    func makeLoginCoordinator(
        navigation: UINavigationController,
        screenFactory: any ScreenFactoryProtocol
    ) -> LoginCoordinator {
        LoginCoordinator(navigation: navigation, screenFactory: screenFactory)
    }
    
    func makeMainTabBarCoordinator(
        navigation: UINavigationController,
        screenFactory: any ScreenFactoryProtocol,
        networkManager: NetworkManagerProtocol
    ) -> MainTabBarCoordinator {
        MainTabBarCoordinator(
            coordinatorFactory: self,
            screenFactory: screenFactory,
            navigation: navigation,
            networkManager: networkManager
        )
    }
    
    func makeMoviesCoordinator(screenFactory: any ScreenFactoryProtocol, networkManager: NetworkManagerProtocol) -> MoviesCoordinator {
        MoviesCoordinator(screenFactory: screenFactory, networkManager: networkManager)
    }
    
    func makeSettingsCoordinator(screenFactory: any ScreenFactoryProtocol) -> SettingsCoordinator {
        SettingsCoordinator(screenFactory: screenFactory)
    }
}

// MARK: - ScreenFactoryProtocol / Impl

protocol ScreenFactoryProtocol {
    func makeLoginController(delegate: LoginViewModelDelegate) -> UIViewController
    func makeCreateAccountController(delegate: CreateAccountViewModelDelegate) -> UIViewController
    func makeMainTabBarController() -> UITabBarController
    func makeMoviesController(networkManager: NetworkManagerProtocol) -> UIViewController
    func makeSettingsController(delegate: SettingsViewModelDelegate) -> UIViewController
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
    
    func makeMoviesController(networkManager: NetworkManagerProtocol) -> UIViewController {
        let viewModel = MoviesViewModel(networkManager: networkManager)
        let moviesController = MoviesViewController(viewModel: viewModel)
        moviesController.delegate = viewModel
        return moviesController
    }
    
    func makeSettingsController(delegate: SettingsViewModelDelegate) -> UIViewController {
        let viewModel = SettingsViewModel()
        viewModel.delegate = delegate
        let settingsController = SettingsViewController(viewModel: viewModel)
        settingsController.delegate = viewModel
        return settingsController
    }
}

// MARK: - TabBarItemFactoryProtocol

protocol TabBarItemFactoryProtocol {}

extension TabBarItemFactoryProtocol {
    func makeTabBarItem(navigation: UINavigationController, title: String, image: String, selectedImage: String) {
        let tabBarItem = UITabBarItem(
            title: title,
            image: UIImage(systemName: image),
            selectedImage: UIImage(systemName: selectedImage)
        )
        navigation.tabBarItem = tabBarItem
    }
}
