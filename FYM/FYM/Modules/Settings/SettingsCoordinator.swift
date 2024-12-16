//
//  SettingsCoordinator.swift
//  FYM
//
//  Created by Nikolai Maksimov on 16.12.2024.
//

import UIKit

final class SettingsCoordinator: BaseCoordinator {
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
        let settingsScreen = screenFactory.makeSettingsController()
        return settingsScreen
    }
}
