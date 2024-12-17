//
//  SettingsViewModel.swift
//  FYM
//
//  Created by Nikolai Maksimov on 16.12.2024.
//

import Foundation

protocol SettingsViewModelDelegate: AnyObject {
    func logOut()
}

protocol SettingsViewModelProtocol {}

final class SettingsViewModel: SettingsViewModelProtocol {
    weak var delegate: SettingsViewModelDelegate?
    
}

// MARK: - SettingsViewDelegate
extension SettingsViewModel: SettingsViewDelegate {
    func didSelectLogOutRow() {
        delegate?.logOut()
    }
}
