//
//  SettingItemViewModel.swift
//  FYM
//
//  Created by Nikolai Maksimov on 16.12.2024.
//

import UIKit

struct SettingItemViewModel {
    var title: String
    var image: String
    var type: ItemType
}

enum ItemType {
    case userConfiguration
    case account
    case theme
    case logOut
    case appVersion
}
