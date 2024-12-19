//
//  MoviesView.swift
//  FYM
//
//  Created by Nikolai Maksimov on 19.12.2024.
//

import UIKit
import SnapKit

protocol MoviesViewDelegate: AnyObject {}

final class MoviesView: UIView {
    weak var delegate: MoviesViewDelegate?
    
    // TODO: - Добавить коллекцию
    // - Header view
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Constraints

private extension MoviesView {
    func commonInit() {
        backgroundColor = .systemBackground
        setupSubviews()
        setupConstraints()
    }
    
    func setupSubviews() {
        
    }
    
    func setupConstraints() {
        
    }
}
