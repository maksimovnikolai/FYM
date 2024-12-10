//
//  LoginViewModel.swift
//  FYM
//
//  Created by Nikolai Maksimov on 02.12.2024.
//

import UIKit

protocol LoginViewModelDelegate: AnyObject {
    func didTapLogInButton()
    func showCreateAccountScreen()
}

protocol LoginViewModelProtocol {}

final class LoginViewModel {
    weak var delegate: LoginViewModelDelegate?
}

// MARK: - LoginViewModelProtocol

extension LoginViewModel: LoginViewModelProtocol {}

// MARK: - LoginViewDelegate

extension LoginViewModel: LoginViewDelegate {
    func didTapLoginButton() {
        delegate?.didTapLogInButton()
    }
    
    func didTapCreateAccount() {
        delegate?.showCreateAccountScreen()
    }
    
    func didTapRememberMeButton() {}
    
    func didTapForgotPasswordButton() {}
}
