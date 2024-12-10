//
//  CreateAccountViewController.swift
//  FYM
//
//  Created by Nikolai Maksimov on 07.12.2024.
//

import UIKit

final class CreateAccountViewController: UIViewController {
    weak var delegate: AccountViewDelegate? {
        get { accountView.delegate }
        set { accountView.delegate = newValue }
    }
    // MARK: - Private properties
    
    private let viewModel: CreateAccountViewModelProtocol
    private let accountView = CreateAccountView()
    
    // MARK: - Init
    
    init(viewModel: CreateAccountViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life cycle
    
    override func loadView() {
        view = accountView
    }
}
