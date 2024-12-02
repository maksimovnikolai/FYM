//
//  LoginCoordinator.swift
//  FYM
//
//  Created by Nikolai Maksimov on 02.12.2024.
//

import UIKit

final class LoginCoordinator: BaseCoordinator {
    // MARK: - Private properties
    
    private let navigation: UINavigationController
    private let screenFactory: ScreenFactoryProtocol
    
    // MARK: - Init
    
    init(navigation: UINavigationController, screenFactory: ScreenFactoryProtocol) {
        self.navigation = navigation
        self.screenFactory = screenFactory
    }
    
    override func start() {
        runLoginFlow()
    }
}

// MARK: - Private methods

private extension LoginCoordinator {
    func runLoginFlow() {
        let vc = UIViewController()
        vc.view.backgroundColor = .red
        navigation.pushViewController(vc, animated: false)
    }
}
