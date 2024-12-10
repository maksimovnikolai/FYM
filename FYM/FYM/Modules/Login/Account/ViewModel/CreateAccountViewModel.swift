//
//  CreateAccountViewModel.swift
//  FYM
//
//  Created by Nikolai Maksimov on 07.12.2024.
//

import Foundation

protocol CreateAccountViewModelDelegate: AnyObject {
    func createAccount()
}

protocol CreateAccountViewModelProtocol {}

final class CreateAccountViewModel {
    weak var delegate: CreateAccountViewModelDelegate?
    
    // TODO: - Добавить логику регистрации пользователя
}

// MARK: - CreateAccountViewModelProtocol

extension CreateAccountViewModel: CreateAccountViewModelProtocol {}

// MARK: - AccountViewDelegate

extension CreateAccountViewModel: AccountViewDelegate {
    func didTapCreateAccountButton() {
        delegate?.createAccount()
    }
}
