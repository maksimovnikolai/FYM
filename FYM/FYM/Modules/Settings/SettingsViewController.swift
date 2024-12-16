//
//  SettingsViewController.swift
//  FYM
//
//  Created by Nikolai Maksimov on 16.12.2024.
//

import UIKit

final class SettingsViewController: UIViewController {
    weak var delegate: SettingsViewDelegate? {
        get { customView.delegate }
        set { customView.delegate = newValue }
    }
    
    // MARK: - Private properties
    
    private let viewModel: SettingsViewModelProtocol
    private let customView = SettingsView()
    
    // MARK: - Init
    
    init(viewModel: SettingsViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life cycle
    
    override func loadView() {
        view = customView
    }
}
