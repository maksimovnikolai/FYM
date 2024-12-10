//
//  LoginViewController.swift
//  FYM
//
//  Created by Nikolai Maksimov on 02.12.2024.
//

import UIKit

final class LoginViewController: UIViewController {
    
    weak var delegate: LoginViewDelegate? {
        get { loginView.delegate }
        set { loginView.delegate = newValue }
    }
    
    // MARK: - Private properties
    
    private let viewModel: LoginViewModelProtocol
    private let loginView = LoginView()
    
    // MARK: - Init
    
    init(viewModel: LoginViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life cycle
    
    override func loadView() {
        view = loginView
    }
}
