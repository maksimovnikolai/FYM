//
//  ApplicationCoordinator.swift
//  FYM
//
//  Created by Nikolai Maksimov on 01.12.2024.
//

import UIKit

final class ApplicationCoordinator: BaseCoordinator {
    // MARK: - Private properties
    
    private let navigationController: UINavigationController
    private let coordinatorFactory: CoordinatorFactoryProtocol
    
    // MARK: - Init
    
    init(navigationController: UINavigationController, coordinatorFactory: CoordinatorFactoryProtocol) {
        self.navigationController = navigationController
        self.coordinatorFactory = coordinatorFactory
    }
    
    override func start() {}
    
}

