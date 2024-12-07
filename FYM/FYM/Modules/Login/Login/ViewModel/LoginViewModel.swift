//
//  LoginViewModel.swift
//  FYM
//
//  Created by Nikolai Maksimov on 02.12.2024.
//

import UIKit

protocol LoginViewModelDelegate: AnyObject {
    func didTapLogInButton()
}

protocol LoginViewModelProtocol {}

final class LoginViewModel {
    weak var delegate: LoginViewModelDelegate?
}

// MARK: - LoginViewModelProtocol

extension LoginViewModel: LoginViewModelProtocol {}

// MARK: - LoginViewDelegate

extension LoginViewModel: LoginViewDelegate {
    func didTapLoginButton() {}
    
    func didTapCreateAccount() {}
    
    func didTapRememberMeButton() {}
    
    func didTapForgotPasswordButton() {}
}
