//
//  MoviesViewController.swift
//  FYM
//
//  Created by Nikolai Maksimov on 19.12.2024.
//

import UIKit

final class MoviesViewController: UIViewController {
    weak var delegate: MoviesViewDelegate? {
        get { customView.delegate }
        set { customView.delegate = newValue }
    }
    
    // MARK: - Private properties
    
    private let customView = MoviesView()
    private let viewModel: MoviesViewModelProtocol
    
    // MARK: - Init
    
    init(viewModel: MoviesViewModelProtocol) {
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
