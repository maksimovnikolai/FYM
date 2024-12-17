//
//  SettingsCoordinator.swift
//  FYM
//
//  Created by Nikolai Maksimov on 16.12.2024.
//

import UIKit

final class SettingsCoordinator: BaseCoordinator {
    var finishFlow: (() -> Void)?
    var rootController: UIViewController {
        makeSettingsScreen()
    }
    
    // MARK: - Private properties
    
    private let screenFactory: ScreenFactoryProtocol
    private let navigation: UINavigationController
    
    // MARK: - Init
    
    init(screenFactory: ScreenFactoryProtocol) {
        self.screenFactory = screenFactory
        self.navigation = UINavigationController()
    }
}

// MARK: - Private methods

private extension SettingsCoordinator {
    func makeSettingsScreen() -> UIViewController {
        let settingsScreen = screenFactory.makeSettingsController(delegate: self)
        settingsScreen.navigationItem.title = "Настройки ⚙️"
        navigation.pushViewController(settingsScreen, animated: true)
        navigation.navigationBar.prefersLargeTitles = true
        makeTabBarItem(for: navigation)
        return navigation
    }
}

// MARK: - SettingsViewModelDelegate

extension SettingsCoordinator: SettingsViewModelDelegate {
    func logOut() {
        finishFlow?()
    }
}

// MARK: - TabBarItemFactoryProtocol

extension SettingsCoordinator: TabBarItemFactoryProtocol {
    func makeTabBarItem(for navigation: UINavigationController) {
        makeTabBarItem(
            navigation: navigation,
            title: "Настройки",
            image: "gearshape.2",
            selectedImage: "gearshape.2.fill"
        )
    }
}
