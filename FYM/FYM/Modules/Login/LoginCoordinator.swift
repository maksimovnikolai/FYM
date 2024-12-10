//
//  LoginCoordinator.swift
//  FYM
//
//  Created by Nikolai Maksimov on 02.12.2024.
//

import UIKit

final class LoginCoordinator: BaseCoordinator {
    var finishFlow: (() -> Void)?
    
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
        let loginViewController = screenFactory.makeLoginController(delegate: self)
        navigation.pushViewController(loginViewController, animated: false)
    }
    
    func runCreateAccountFlow() {
        let createAccountController = screenFactory.makeCreateAccountController(delegate: self)
        navigation.pushViewController(createAccountController, animated: true)
        navigation.navigationBar.topItem?.backButtonTitle = "Назад"
    }
}

// MARK: - LoginViewModelDelegate

extension LoginCoordinator: LoginViewModelDelegate {
    func didTapLogInButton() {
        finishFlow?()
    }
    
    func showCreateAccountScreen() {
        runCreateAccountFlow()
    }
}

// MARK: - CreateAccountViewModelDelegate

extension LoginCoordinator: CreateAccountViewModelDelegate {
    func createAccount() {}
}
